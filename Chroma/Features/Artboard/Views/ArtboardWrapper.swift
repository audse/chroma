//
//  CanvasWrapper.swift
//  Chroma
//
//  Created by Audrey Serene on 9/15/23.
//

import SwiftUI

// This class exists to contain EditableCanvas and update
// it's zoom/translation based on gestures. This logic does not
// live in EditableCanvas because that messes up the mouseLocation code.

struct ArtboardWrapper: View {
    @EnvironmentObject var currentArtboard: CurrentArtboardViewModel
    @EnvironmentObject var workspaceSettings: WorkspaceSettingsModel
    @Environment(\.colorScheme) var colorScheme
    
    @State var currentZoom: CGFloat = 1.0
    
    var body: some View {
        ScrollView(Axis.Set([.horizontal, .vertical]), showsIndicators: false) {
            ZStack {
                Rectangle()
                    .fill(getWorkspaceBgColor())
                    .ignoresSafeArea()
                if workspaceSettings.tileMode == .both || workspaceSettings.tileMode == .horizontal {
                    makeCanvas(w: -1, h: 0) // Left
                    makeCanvas(w: 1, h: 0) // Right
                }
                
                if workspaceSettings.tileMode == .both || workspaceSettings.tileMode == .vertical {
                    makeCanvas(w: 0, h: -1) // Top
                    makeCanvas(w: 0, h: 1) // Bottom
                }
                
                if workspaceSettings.tileMode == .both {
                    makeCanvas(w: 1, h: 1) // Bottom right
                    makeCanvas(w: 1, h: -1) // Top right
                    makeCanvas(w: -1, h: -1) // Top left
                    makeCanvas(w: -1, h: 1) // Bottom left
                }
                EditableArtboard().fixedSize()
            }.frame(
                width: currentArtboard.size.width * 6,
                height: currentArtboard.size.height * 6
            )
            .fixedSize()
            .zoomable(zoom: $currentZoom, onChanged: { newValue in
                workspaceSettings.zoom = newValue
            })
        }.background(Color.accentColor)
    }
    
    func getWorkspaceBgColor() -> Color {
        switch workspaceSettings.backgroundColor {
            case .followColorScheme: return colorScheme == .dark
                ? WorkspaceBackgroundColor.defaultDark
                : WorkspaceBackgroundColor.defaultLight
            case .custom(let color): return color
        }
    }
    
    func makeCanvas(w: CGFloat = 1.0, h: CGFloat = 1.0) -> some View {
        EditableArtboard()
            .fixedSize()
            .offset(x: currentArtboard.size.width * w *  workspaceSettings.zoom, y: currentArtboard.size.height * h * workspaceSettings.zoom)
            .opacity(0.5)
    }
}

struct ArtboardWrapper_Previews: PreviewProvider {
    static var previews: some View {
        ArtboardWrapper()
            .environmentObject(CurrentArtboardViewModel().withNewLayer([
                Pixel(position: CGPoint(100))
            ]))
            .environmentObject(WorkspaceSettingsModel())
            .environmentObject(DrawSettings())
            .environmentObject(History())
    }
}
