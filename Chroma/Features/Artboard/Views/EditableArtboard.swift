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
    
    @State var lineGhostPixels: [PixelModel] = []
    
    var body: some View {
        ZStack {
            Artboard(artboard: file.artboard)
                .onTapGesture { location in
                    let adjustedLocation = location - drawSettings.getPixelSize() / 2.0
                    switch drawSettings.tool {
                        case .draw: draw(adjustedLocation)
                        case .erase: erase(adjustedLocation)
                        case .fill: fill(adjustedLocation)
                        case .eyedropper: eyedrop(adjustedLocation)
                        case .line: line(adjustedLocation)
                    }
                }
                .onHover { isHoveringValue in
                    isHovering = isHoveringValue
                }
                .onContinuousHover(perform: { phase in
                    if case .active(let location) = phase {
                        mouseLocation = location
                        
                        if drawSettings.tool == .line {
                            if let pointA = drawSettings.multiClickState.first {
                                lineGhostPixels = drawSettings.createPixelsBetweenPoints(pointA, location - drawSettings.getPixelSize() / 2.0)
                            }
                        }
                    }
                })
                .releaseFocusOnTap()
            if drawSettings.tool == .line {
                DrawLineGhost(ghostPixels: $lineGhostPixels)
            }
            if isHovering {
                PixelCursor()
                    .position(drawSettings.snapped(mouseLocation - drawSettings.getPixelSize() / 2.0) + drawSettings.getPixelSize() / 2.0)
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
                drawSettings.tool = .draw
                return
            }
        }
    }
    
    func line(_ location: CGPoint) {
        if let pointA = drawSettings.multiClickState.first {
            if let layer = file.artboard.currentLayer {
                drawSettings.multiClickState.removeAll()
                let pixels: [PixelModel] = drawSettings.createPixelsBetweenPoints(pointA, location)
                pixels.forEach(layer.addPixel)
                history.add(LineAction(pixels, layer))
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
