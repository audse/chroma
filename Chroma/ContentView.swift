//
//  ContentView.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appSettings: AppSettingsModel
    
    var body: some View {
        ZStack {
            ArtboardWrapper()
            HStack {
                VStack(spacing: 8) {
                    PixelSizeControl().panel()
                    ColorControl().panel()
                    ToolList().panel()
                    VStack {
                        HistoryButtons()
                        HistoryList().expandHeight()
                    }.panel()
                }
                Spacer()
                HStack {
                    RotationControl().panel()
                    ShapeList().panel()
                    ScaleTypeButtons().panel()
                }.expandHeight(alignment: .top)
                Spacer()
                VStack(alignment: .trailing) {
                    WorkspaceSettingsPanel()
                    ArtboardSettingsPanel()
                    Spacer()
                    Minimap()
                        .shadow(color: Color(hue: 0, saturation: 0, brightness: 0, opacity: 0.1), radius: 4, y: 2)
                        .padding()
                }
            }
            .padding()
        }
        .composableButtonStyle(
            Btn.defaultPadding
            |> Btn.hStack
            |> Btn.filledAccent
            |> Btn.rounded
            |> Btn.scaled
        )
        .preferredColorScheme(appSettings.colorSchemeValue)
        .onAppear { Task {
            releaseFocus()
        } }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var artboard = ArtboardModel()
    static var previews: some View {
        ContentView()
            .environmentObject(AppSettingsModel())
            .environmentObject(DrawSettings())
            .environmentObject(FileViewModel(FileModel(artboard: artboard)))
            .environmentObject(History())
    }
}
