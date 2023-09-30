//
//  EditableArtboard.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI
import Extensions

struct EditableArtboard: View {
    @EnvironmentObject var drawSettings: DrawSettings
    @EnvironmentObject var workspaceSettings: WorkspaceSettingsModel
    @EnvironmentObject var file: FileModel
    @EnvironmentObject var history: History

    @State var isHovering = false
    @State var mouseLocation = CGPoint()

    @State var ghostPixels: [PixelModel] = []
    
    @State var dragState = DragPathState.inactive
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.almostClear)
                .onKeyPressEvent(.delete, modifiers: []) {
                    eraseSelection()
                }
            
            Artboard(artboard: file.artboard)
                .onTapGesture(perform: onTap)
                .onHover { isHoveringValue in
                    isHovering = isHoveringValue
                }
                .onContinuousHover(coordinateSpace: .local, perform: onContinuousHover)
                .releaseFocusOnTap()
                .dragPathGesture(
                    state: $dragState,
                    minimumDistance: 2,
                    onChanged: onDragChanged,
                    onBeforeEnded: onDragEnded
                )
            
            if [.lassoSelect, .rectSelect].contains(drawSettings.tool) {
                if case .dragging(let path) = dragState {
                    DrawSelection(tool: drawSettings.tool, points: path)
                }
            }
            
            if [
                .line(.positive), 
                .line(.negative),
                .rect(.positive),
                .rect(.negative),
                .move
            ].contains(drawSettings.tool) {
                CancelToolButton()
            }
            DrawGhost(ghostPixels: $ghostPixels)
            
            if isHovering {
                let cursorShouldSnap = ![.eyedropper, .fill].contains(drawSettings.tool)
                PixelCursor()
                    .if(!cursorShouldSnap) { view in
                        view.position(mouseLocation)
                    }
                    .if(cursorShouldSnap) { view in
                        view.position(drawSettings.snapped(mouseLocation) + drawSettings.getPixelSize() / 2.0)
                    }
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
    
    func onDragChanged(_ value: DragPathState) {
        ghostPixels = getGhostPixels(value.last)
    }
    
    func onDragEnded(_ value: DragPathState) {
        if [.rectSelect, .lassoSelect].contains(drawSettings.tool) {
            selectPath(value.points)
        }
        if drawSettings.tool == .move {
            move(value.points)
        }
        if [.draw(.positive), .draw(.negative)].contains(drawSettings.tool) {
            drawPath(value.points)
        }
        if drawSettings.tool == .erase {
            erasePath(value.points)
        }
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
            let first = drawSettings.snapped(dragState.first)
            let last = drawSettings.snapped(dragState.last)
            return history.getCurrentSelection().map { pixel in
                let newPixel = pixel.duplicate()
                newPixel.setPosition(drawSettings.snapped(pixel.position + last - first))
                return newPixel.pixel
            }
        case .draw, .erase:
            return drawSettings.createPixelPath(dragState.points)
        default: return []
        }
    }
    
    func draw(_ location: CGPoint) {
        withCurrentLayer { layer in
            let model = drawSettings.createPixel(location)
            let pixel = drawSettings.tool.isPositive ? model.positive() : model.negative()
            history.add(DrawAction(pixel, layer))
        }
    }
    
    func drawPath(_ points: [CGPoint]) {
        withCurrentLayer { layer in
            let pixelsToAdd = drawSettings.createPixelPath(points).map { pixel in
                drawSettings.tool.isPositive ? pixel.positive() : pixel.negative()
            }
            if !pixelsToAdd.isEmpty {
                history.add(DrawMultipleAction(pixelsToAdd, layer))
            }
        }
    }

    func erase(_ location: CGPoint) {
        withCurrentLayer { layer in
            if let (_, pixel) = layer.findPixel(location) {
                history.add(EraseAction(pixel, layer))
            }
        }
    }
    
    func erasePath(_ points: [CGPoint]) {
        withCurrentLayer { layer in
            let pixelsToErase = points
                .map(layer.findPixel)
                .filterSome()
                .map { (_, pixel) in pixel }
                .unique()
            history.add(EraseMultipleAction(pixelsToErase, layer))
        }
    }
    
    func eraseSelection() {
        withCurrentLayer { layer in
            history.add(EraseSelectionAction(history.getCurrentSelection(), layer))
        }
    }

    func fill(_ location: CGPoint) {
        withCurrentLayer { layer in
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
        let renderer = ImageRenderer(content: Artboard(artboard: file.artboard))
        let color = renderer.cgImage?.getPixelColor(at: location) ?? .black
        drawSettings.color = color
        
        var previousTool: Tool = .draw(.positive)
        for action in history.history.reversed() {
            if let action = action as? SelectToolAction,
               action.tool != .eyedropper {
                previousTool = action.tool
                break
            }
        }
        history.add(SelectToolAction(previousTool, drawSettings))
    }

    func line(_ location: CGPoint) {
        withCurrentLayer { layer in
            if let pointA = drawSettings.multiClickState.first {
                drawSettings.multiClickState.removeAll()
                let pixels = drawSettings.createPixelLine(pointA, location)
                    .map { pixel in
                        drawSettings.tool.isPositive
                        ? pixel.positive()
                        : pixel.negative()
                    }
                history.add(LineAction(pixels, layer))
            } else {
                drawSettings.multiClickState = [location]
            }
        }
    }

    func rect(_ location: CGPoint) {
        withCurrentLayer { layer in
            if let pointA = drawSettings.multiClickState.first {
                drawSettings.multiClickState.removeAll()
                let pixels = drawSettings.createPixelRect(pointA, location)
                    .map { pixel in
                        drawSettings.tool.isPositive
                        ? pixel.positive()
                        : pixel.negative()
                    }
                history.add(RectAction(pixels, layer))
            } else {
                drawSettings.multiClickState = [location]
            }
        }
    }
    
    func selectPath(_ path: [CGPoint]) {
        withCurrentLayer { layer in
            let selectionPath: Path = DrawSelection(tool: drawSettings.tool, points: path).getShape()
            let pixels = layer.getSelectedPixels(in: selectionPath)
            history.add(SelectAction(pixels, layer))
        }
    }
    
    func move(_ path: [CGPoint]) {
        withCurrentLayer { _ in
            let first = drawSettings.snapped(dragState.first)
            let last = drawSettings.snapped(dragState.last)
            history.add(MoveAction(
                history.getCurrentSelection(),
                drawSettings: drawSettings,
                delta: last - first
            ))
        }
    }
    
    func withCurrentLayer(_ closure: (LayerModel) -> Void) {
        if let layer = history.getCurrentLayer() {
            if layer.isVisible && !layer.isLocked {
                closure(layer)
            }
        }
    }
    
}

#Preview {
    EditableArtboard(mouseLocation: CGPoint(x: 33, y: 31))
        .environmentObject(
            FileModel(artboard: PreviewArtboardModelBuilder().build())
        )
        .environmentObject(DrawSettings())
        .environmentObject(History())
        .environmentObject(WorkspaceSettingsModel())
}
