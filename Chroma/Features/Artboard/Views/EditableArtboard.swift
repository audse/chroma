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
    @EnvironmentObject var currentArtboard: ArtboardViewModel
    @EnvironmentObject var history: History
    
    @State var isHovering = true
    @State var mouseLocation = CGPoint()
    
    var body: some View {
        ZStack {
            Artboard(artboard: currentArtboard)
                .onTapGesture { location in
                    switch drawSettings.tool {
                    case .draw: draw(location - drawSettings.getPixelSize() / 2.0)
                    case .erase: erase(location - drawSettings.getPixelSize() / 2.0)
                    }
                }
                .onHover { isHoveringValue in
                    isHovering = isHoveringValue
                }
                .onContinuousHover(perform: { phase in
                    if case .active(let location) = phase {
                        mouseLocation = location
                    }
                })
            if isHovering {
                PixelCursor()
                    .position(drawSettings.snapped(mouseLocation - drawSettings.getPixelSize() / 2.0) + drawSettings.getPixelSize() / 2.0)
                    .animation(.easeInOut(duration: 0.1), value: mouseLocation)
            }
        }
        .frame(width: currentArtboard.size.width, height: currentArtboard.size.height)
        .clipped()
        .scaleEffect(workspaceSettings.zoom)
        .animation(.easeInOut(duration: 0.2), value: workspaceSettings.zoom)
    }
    
    func draw(_ location: CGPoint) {
        if let layer = currentArtboard.layer {
            let pixel = drawSettings.createPixel(location)
            layer.addPixel(pixel)
            history.add(DrawAction(pixel, layer))
        }
    }
    
    func erase(_ location: CGPoint) {
        if let layer = currentArtboard.layer {
            let idx: Int = layer.findPixel(location)
            if idx != -1 {
                let pixel = layer.removePixel(idx)
                history.add(EraseAction(pixel, idx, layer))
            }
        }
    }
}

struct EditableCanvas_Previews: PreviewProvider {
    private static var currentArtboard = ArtboardViewModel().withNewLayer([
        PixelModel(shape: SquareShape),
        PixelModel(shape: CircleShape, position: CGPoint(250)),
        PixelModel(shape: SquareShape, color: Color.blue, position: CGPoint(100))
    ])
    
    static var previews: some View {
        EditableArtboard(mouseLocation: CGPoint(x: 33, y: 31))
            .environmentObject(currentArtboard)
            .environmentObject(DrawSettings())
            .environmentObject(History())
    }
}
