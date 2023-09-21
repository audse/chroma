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
    
    var body: some View {
        ZStack {
            Artboard(artboard: file.artboard)
                .onTapGesture(perform: onTap)
                .onHover { isHoveringValue in
                    isHovering = isHoveringValue
                }
                .onContinuousHover(perform: onContinuousHover)
                .onChange(of: drawSettings.tool) { _ in
                    ghostPixels.removeAll()
                }
                .releaseFocusOnTap()
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
    
    func draw(_ location: CGPoint) {
        if let layer = file.artboard.currentLayer {
            let pixel = drawSettings.createPixel(location)
            layer.addPixel(pixel)
            history.add(DrawAction(pixel, layer))
        }
    }
    
    func erase(_ location: CGPoint) {
        if let layer = file.artboard.currentLayer {
            let idx: Int = layer.findPixel(location)
            if idx != -1 {
                let pixel = layer.removePixel(idx)
                history.add(EraseAction(pixel, idx, layer))
            }
        }
    }
    
    func fill(_ location: CGPoint) {
        if let layer = file.artboard.currentLayer {
            let pixelsToFill = layer.getPixelsToFill(location)
            if let startPixel = pixelsToFill.first {
                let originalColor = startPixel.color
                pixelsToFill.forEach { px in px.setColor(drawSettings.color) }
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
                pixels.forEach(layer.addPixel)
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
                pixels.forEach(layer.addPixel)
                history.add(RectAction(pixels, layer))
            }
        } else {
            drawSettings.multiClickState = [location]
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
