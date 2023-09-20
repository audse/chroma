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
    @EnvironmentObject var file: FileViewModel
    @EnvironmentObject var history: History
    
    @State var isHovering = true
    @State var mouseLocation = CGPoint()
    
    var body: some View {
        ZStack {
            Artboard(artboard: file.artboard)
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
                .releaseFocusOnTap()
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
        if let layer = file.artboard.layer {
            let pixel = drawSettings.createPixel(location)
            layer.addPixel(pixel)
            history.add(DrawAction(pixel, layer))
        }
    }
    
    func erase(_ location: CGPoint) {
        if let layer = file.artboard.layer {
            let idx: Int = layer.findPixel(location)
            if idx != -1 {
                let pixel = layer.removePixel(idx)
                history.add(EraseAction(pixel, idx, layer))
            }
        }
    }
}

struct EditableCanvas_Previews: PreviewProvider {
    static var previews: some View {
        EditableArtboard(mouseLocation: CGPoint(x: 33, y: 31))
            .environmentObject(FileViewModel(
                FileModel(artboard: PreviewArtboardModelBuilder().build())
            ))
            .environmentObject(DrawSettings())
            .environmentObject(History())
            .environmentObject(WorkspaceSettingsModel())
    }
}
