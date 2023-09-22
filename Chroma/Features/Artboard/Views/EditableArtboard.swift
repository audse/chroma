//
//  EditableArtboard.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct EditableArtboard: View {
    @EnvironmentObject var drawSettings: DrawSettings
    @EnvironmentObject var workspaceSettings: WorkspaceSettingsModel
    @EnvironmentObject var file: FileModel
    @EnvironmentObject var history: History

    @State var isHovering = true
    @State var mouseLocation = CGPoint()

    @State var ghostPixels: [PixelModel] = []
    
    enum DragState: Equatable {
        case inactive
        case dragging([CGPoint])
    }
    
    @State private var dragState = DragState.inactive
    
    var body: some View {
        ZStack {
            
            Button("") {
                eraseSelection()
            }.buttonStyle(.plain)
                .labelsHidden()
                .keyboardShortcut("x", modifiers: [.command])
            
            let drag = DragGesture(minimumDistance: 10)
                .onChanged { value in
                    if [.rectSelect, .lassoSelect].contains(drawSettings.tool) {
                        if case .dragging(var currentPath) = dragState {
                            currentPath.append(value.location)
                            dragState = .dragging(currentPath)
                        } else {
                            dragState = .dragging([value.location])
                        }
                    }
                }
                .onEnded { _ in
                    if [.rectSelect, .lassoSelect].contains(drawSettings.tool) {
                        if case .dragging(let currentPath) = dragState {
                            selectPath(currentPath)
                        }
                        dragState = .inactive
                    }
                }
            
            Artboard(artboard: file.artboard)
                .onTapGesture(perform: onTap)
                .gesture(DragGesture(minimumDistance: 10))
                .onHover { isHoveringValue in
                    isHovering = isHoveringValue
                }
                .onContinuousHover(perform: onContinuousHover)
                .onChange(of: drawSettings.tool) { _ in
                    ghostPixels.removeAll()
                }
                .releaseFocusOnTap()
                .simultaneousGesture(drag)
            
            if drawSettings.tool == .rectSelect {
                if case .dragging(let path) = dragState {
                    getSelectionRect(path)
                        .stroke(.black, style: StrokeStyle(
                            lineWidth: 1.25,
                            dash: [4]
                        ))
                        .shadow(color: .white, radius: 0, x: 1, y: 0)
                        .shadow(color: .white, radius: 0, x: 0, y: 1)
                        .shadow(color: .white, radius: 0, x: -1, y: 0)
                        .shadow(color: .white, radius: 0, x: 0, y: -1)
                        .allowsHitTesting(false)
                }
            }
            
            if drawSettings.tool == .lassoSelect {
                if case .dragging(let path) = dragState {
                    getSelectionShape(path)
                        .stroke(.black, style: StrokeStyle(
                            lineWidth: 1.25,
                            dash: [4]
                        ))
                        .shadow(color: .white, radius: 0, x: 1, y: 0)
                        .shadow(color: .white, radius: 0, x: 0, y: 1)
                        .shadow(color: .white, radius: 0, x: -1, y: 0)
                        .shadow(color: .white, radius: 0, x: 0, y: -1)
                        .allowsHitTesting(false)
                }
            }
            
            if [.line, .rect].contains(drawSettings.tool) {
                CancelToolButton(ghostPixels: $ghostPixels)
                DrawGhost(ghostPixels: $ghostPixels)
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

    func adjust(_ location: CGPoint) -> CGPoint {
        return location - drawSettings.getPixelSize() / 2.0
    }

    func onTap(_ location: CGPoint) {
        let adjustedLocation = adjust(location)
        switch drawSettings.tool {
        case .draw: draw(adjustedLocation)
        case .erase: erase(adjustedLocation)
        case .fill: fill(adjustedLocation)
        case .eyedropper: eyedrop(adjustedLocation)
        case .line: line(adjustedLocation)
        case .rect: rect(adjustedLocation)
        case .rectSelect, .lassoSelect: break
        }
    }

    func onContinuousHover(_ phase: HoverPhase) {
        if case .active(let location) = phase {
            mouseLocation = adjust(location)
            ghostPixels = getGhostPixels(location)
        }
    }

    func getGhostPixels(_ location: CGPoint) -> [PixelModel] {
        switch drawSettings.tool {
        case .line:
            switch drawSettings.multiClickState.first {
            case .some(let pointA): return drawSettings.createPixelLine(pointA, adjust(location))
            case .none: return []
            }
        case .rect:
            switch drawSettings.multiClickState.first {
            case .some(let pointA): return drawSettings.createPixelRect(pointA, adjust(location))
            case .none: return []
            }
        default: return []
        }
    }
    
    func getSelectionRect(_ currentPath: [CGPoint]) -> Path {
        var path = Path()
        if let firstPoint = currentPath.first {
            if let lastPoint = currentPath.last {
                path.addRect(CGRect(start: firstPoint, end: lastPoint))
            }
        }
        return path
    }
    
    func getSelectionShape(_ currentPath: [CGPoint]) -> Path {
        var path = Path()
        if let firstPoint = currentPath.first {
            path.move(to: firstPoint)
        }
        currentPath.forEach { point in
            path.addLine(to: point)
        }
        return path
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
            var selectionPath: Path
            switch drawSettings.tool {
            case .rectSelect: selectionPath = getSelectionRect(path)
            case .lassoSelect: selectionPath = getSelectionShape(path)
            default: selectionPath = Path()
            }
            let pixels = layer.getSelectedPixels(in: selectionPath)
            history.add(RectSelectAction(pixels, layer))
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
