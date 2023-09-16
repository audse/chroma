//
//  ContentView.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            CanvasWrapper()
            VStack(spacing: 8) {
                HStack {
                    RotationControl().panel()
                    ShapeList().panel()
                    ScaleTypeButtons().panel()
                }
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
                    ViewSettingsPanel().expandHeight(alignment: .top)
                }
            }
            .padding()
            Minimap()
                .shadow(color: Color(hue: 0, saturation: 0, brightness: 0, opacity: 0.1), radius: 4, y: 2)
                .expand(alignment: .bottomTrailing)
                .padding()
        }
        .composableButtonStyle(
            Btn.defaultPadding
            |> Btn.hStack
            |> Btn.tinted
            |> Btn.rounded
            |> Btn.scaled
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DrawSettings())
            .environmentObject(CanvasPixels())
            .environmentObject(History())
            .environment(\.startTranslation, .constant(CGSize(300)))
            .environment(\.currentTranslation, .constant(CGSize(300)))
    }
}
