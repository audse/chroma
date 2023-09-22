//
//  EditableArtboard.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

private enum DragState: Equatable {
    case inactive
    case dragging([CGPoint])
    
    var points: [CGPoint] {
        switch self {
        case .dragging(let points): return points
        default: return []
        }
    }
    
    var last: CGPoint {
        return points.last ?? CGPoint()
    }
    
    var first: CGPoint {
        return points.first ?? CGPoint()
    }
    
    var delta: CGSize {
        let first = self.first, last = self.last
        return CGSize(
            width: last.x - first.x,
            height: last.y - first.y
        )
    }
}

struct EditableArtboard: View {
    @EnvironmentObject var drawSettings: DrawSettings
    @EnvironmentObject var workspaceSettings: WorkspaceSettingsModel
    @EnvironmentObject var file: FileModel
    @EnvironmentObject var history: History

    @State var isHovering = true
    @State var mouseLocation = CGPoint()

    @State var ghostPixels: [PixelModel] = []
    
    @State private var dragState = DragState.inactive
    
    var body: some View {
        ZStack {
            
            Button("") {
                eraseSelection()
            }.buttonStyle(.plain)
                .labelsHidden()
                .keyboardShortcut("x", modifiers: [.command])
            
            let drag = DragGesture(minimumDistance: drawSettings.getPixelSize() / 2)
                .onChanged(onDragChanged)
                .onEnded { _ in onDragEnded() }
            
            Artboard(artboard: file.artboard)
                .onTapGesture(perform: onTap)
                .onHover { isHoveringValue in
                    isHovering = isHoveringValue
                }
                .onContinuousHover(perform: onContinuousHover)
                .releaseFocusOnTap()
                .simultaneousGesture(drag)
            
            if [.lassoSelect, .rectSelect].contains(drawSettings.tool) {
                if case .dragging(let path) = dragState {
                    DrawSelection(tool: drawSettings.tool, points: path)
                }
            }
            
            if [.line, .rect, .move].contains(drawSettings.tool) {
                CancelToolButton(ghostPixels: $ghostPixels)
                DrawGhost(ghostPixels: $ghostPixels)
                    .onChange(of: drawSettings.tool) { _ in
                        ghostPixels.removeAll()
                    }
                    .onChange(of: file.artboard.currentLayer) { _ in
                        ghostPixels.removeAll()
                    }
            }
            if isHovering {
                PixelCursor()
                    .position(drawSettings.snapped(mouseLocation) + drawSettings.getPixelSize() / 2.0)
                    .animation(.easeInOut(duration: 0.1), value: mouseLocation)
            }
            if workspaceSettings.gridMode == .dots {
                DotsGridView()
            }
            if workspaceSettings.gridMode == .lines {
                LinesGridView()
            }
            Selection()
        }
        .frame(width: file.artboard.size.width, height: file.artboard.size.height)
        .clipped()
        .scaleEffect(workspaceSettings.zoom)
        .animation(.easeInOut(duration: 0.2), value: workspaceSettings.zoom)
    }

    func onTap(_ location: CGPoint) {
        switch drawSettings.tool {
        case .draw: draw(location)
        case .erase: erase(location)
        case .fill: fill(location)
        case .eyedropper: eyedrop(location)
        case .line: line(location)
        case .rect: rect(location)
        case .rectSelect, .lassoSelect, .move: break
        }
    }
    
    func onDragChanged(value: DragGesture.Value) {
        switch dragState {
        case .inactive: dragState = .dragging([value.location])
        case .dragging(var points):
            points.append(value.location)
            dragState = .dragging(points)
        }
        ghostPixels = getGhostPixels(value.location)
    }
    
    func onDragEnded() {
        if case .dragging(let currentPath) = dragState {
            if [.rectSelect, .lassoSelect].contains(drawSettings.tool) {
                selectPath(currentPath)
            }
            if drawSettings.tool == .move {
                move(currentPath)
            }
        }
        dragState = .inactive
    }

    func onContinuousHover(_ phase: HoverPhase) {
        if case .active(let location) = phase {
            mouseLocation = location
            ghostPixels = getGhostPixels(location)
        } else {
            ghostPixels = []
        }
    }

    func getGhostPixels(_ location: CGPoint) -> [PixelModel] {
        switch drawSettings.tool {
        case .line:
            switch drawSettings.multiClickState.first {
            case .some(let pointA): return drawSettings.createPixelLine(pointA, location)
            case .none: return []
            }
        case .rect:
            switch drawSettings.multiClickState.first {
            case .some(let pointA): return drawSettings.createPixelRect(pointA, location)
            case .none: return []
            }
        case .move:
            if let layer = file.artboard.currentLayer {
                let first = drawSettings.snapped(dragState.first)
                let last = drawSettings.snapped(dragState.last)
                return layer.selectedPixels.map { pixel in
                    let newPixel = pixel.duplicate()
                    newPixel.position = drawSettings.snapped(pixel.position + last - first)
                    return newPixel
                }
            }
            return []
        default: return []
        }
    }
    
    func draw(_ location: CGPoint) {
        if let layer = file.artboard.currentLayer {
            let pixel = drawSettings.createPixel(location)
            history.add(DrawAction(pixel, layer))
        }
    }

    func erase(_ location: CGPoint) {
        if let layer = file.artboard.currentLayer {
            if let (index, pixel) = layer.findPixel(location) {
                history.add(EraseAction(pixel, index, layer))
            }
        }
    }
    
    func eraseSelection() {
        if let layer = file.artboard.currentLayer {
            history.add(EraseSelectionAction(layer.selectedPixels, layer))
        }
    }

    func fill(_ location: CGPoint) {
        if let layer = file.artboard.currentLayer {
            let pixelsToFill = layer.getPixelsToFill(location)
            if let startPixel = pixelsToFill.first {
                let originalColor = startPixel.color
                history.add(FillAction(
                    pixelsToFill,
                    originalColor: originalColor,
                    newColor: drawSettings.color
                ))
            }
        }
    }

    func eyedrop(_ location: CGPoint) {
        for layer in file.artboard.visibleLayers.reversed() {
            if let pixel: PixelModel = layer.findPixel(location) {
                drawSettings.color = pixel.color
                drawSettings.setTool(.draw)
                return
            }
        }
    }

    func line(_ location: CGPoint) {
        if let pointA = drawSettings.multiClickState.first {
            if let layer = file.artboard.currentLayer {
                drawSettings.multiClickState.removeAll()
                let pixels = drawSettings.createPixelLine(pointA, location)
                history.add(LineAction(pixels, layer))
            }
        } else {
            drawSettings.multiClickState = [location]
        }
    }

    func rect(_ location: CGPoint) {
        if let pointA = drawSettings.multiClickState.first {
            if let layer = file.artboard.currentLayer {
                drawSettings.multiClickState.removeAll()
                let pixels = drawSettings.createPixelRect(pointA, location)
                history.add(RectAction(pixels, layer))
            }
        } else {
            drawSettings.multiClickState = [location]
        }
    }
    
    func selectPath(_ path: [CGPoint]) {
        if let layer = file.artboard.currentLayer {
            let selectionPath: Path = DrawSelection(tool: drawSettings.tool, points: path).getShape()
            let pixels = layer.getSelectedPixels(in: selectionPath)
            history.add(SelectAction(pixels, layer))
        }
    }
    
    func move(_ path: [CGPoint]) {
        let first = drawSettings.snapped(dragState.first)
        let last = drawSettings.snapped(dragState.last)
        if let layer = file.artboard.currentLayer {
            history.add(MoveAction(
                layer.selectedPixels,
                drawSettings: drawSettings,
                delta: last - first
            ))
        }
    }
    
}

struct EditableCanvas_Previews: PreviewProvider {
    static var previews: some View {
        EditableArtboard(mouseLocation: CGPoint(x: 33, y: 31))
            .environmentObject(
                FileModel(artboard: PreviewArtboardModelBuilder().build())
            )
            .environmentObject(DrawSettings())
            .environmentObject(History())
            .environmentObject(WorkspaceSettingsModel())
    }
}
