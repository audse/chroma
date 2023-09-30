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
    @EnvironmentObject var file: FileModel
    @EnvironmentObject var workspaceSettings: WorkspaceSettingsModel
    @Environment(\.colorScheme) var colorScheme

    @State var currentZoom: CGFloat = 1.0

    var body: some View {
        ScrollView(Axis.Set([.horizontal, .vertical]), showsIndicators: false) {
            ZStack {
                Rectangle()
                    .fill(getWorkspaceBgColor())
                    .ignoresSafeArea()
                    .releaseFocusOnTap()
                
                EditableArtboard().fixedSize()
                
                if workspaceSettings.tileMode == .both || workspaceSettings.tileMode == .horizontal {
                    makeArtboard(w: -1, h: 0) // Left
                    makeArtboard(w: 1, h: 0) // Right
                }

                if workspaceSettings.tileMode == .both || workspaceSettings.tileMode == .vertical {
                    makeArtboard(w: 0, h: -1) // Top
                    makeArtboard(w: 0, h: 1) // Bottom
                }

                if workspaceSettings.tileMode == .both {
                    makeArtboard(w: 1, h: 1) // Bottom right
                    makeArtboard(w: 1, h: -1) // Top right
                    makeArtboard(w: -1, h: -1) // Top left
                    makeArtboard(w: -1, h: 1) // Bottom left
                }
            }.frame(
                width: max(file.artboard.size.width * 6, 2000),
                height: max(file.artboard.size.height * 6, 1400)
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

    func makeArtboard(w: CGFloat = 1.0, h: CGFloat = 1.0) -> some View {
        EditableArtboard()
            .overlay(
                Rectangle()
                    .fill(getWorkspaceBgColor().opacity(to: 0.5))
                    .allowsHitTesting(false)
                    .frame(
                        width: file.artboard.size.width *  workspaceSettings.zoom,
                        height: file.artboard.size.height *  workspaceSettings.zoom
                    )
                    .animation(.easeInOut(duration: 0.2), value: workspaceSettings.zoom)
            )
            .fixedSize()
            .offset(
                x: file.artboard.size.width * w *  workspaceSettings.zoom,
                y: file.artboard.size.height * h * workspaceSettings.zoom
            )
    }
}

#Preview {
    ArtboardWrapper()
        .environmentObject(FileModel(artboard: ArtboardModel().withNewLayer([
            PixelModel(position: CGPoint(100)).positive()
        ])))
        .environmentObject(WorkspaceSettingsModel(
            tileMode: .both
        ))
        .environmentObject(DrawSettings())
        .environmentObject(History())
}
