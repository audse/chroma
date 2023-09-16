//
//  ChromaApp.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

@main
struct ChromaApp: App {
    @StateObject var drawSettings = DrawSettings()
    @StateObject var canvasPixels = CanvasPixels()
    @StateObject var history = History()
    
    @State var canvasSize = CGSize(512)
    @State var canvasBgColor: Color = .white
    @State var zoom: CGFloat = 1.0
    @State var startTranslation = CGSize(width: 550, height: 350)
    @State var currentTranslation = CGSize(width: 550, height: 350)
    @State var tileMode: TileMode = .none
    
    var body: some Scene {
        WindowGroup("Chroma") {
            ContentView()
                .environmentObject(drawSettings)
                .environmentObject(canvasPixels)
                .environmentObject(history)
                .environment(\.zoom, $zoom)
                .environment(\.startTranslation, $startTranslation)
                .environment(\.currentTranslation, $currentTranslation)
                .environment(\.tileMode, $tileMode)
                .environment(\.canvasBgColor, $canvasBgColor)
                .environment(\.canvasSize, $canvasSize)
                .frame(idealWidth: 2000, idealHeight: 800)
                .toolbar {
                    ToolbarItemGroup {
                        Button {} label: {
                            Image(systemName: "chevron.left")
                        }.buttonStyle(.plain)
                        Spacer()
                        Text("New Canvas")
                        Spacer()
                        ZoomButtons()
                            .environment(\.zoom, $zoom)
                    }
                }
        }
        .windowToolbarStyle(.unifiedCompact(showsTitle: false))
            .commands {
                CommandMenu("Export") {
                    Button("Export as PNG...") {
                        if let url = makeSavePanel([.png]) {
                            savePng(
                                view: CanvasBase()
                                        .environmentObject(canvasPixels)
                                        .environment(\.canvasBgColor, $canvasBgColor)
                                        .environment(\.canvasSize, $canvasSize),
                                url: url
                            )
                        }
                    }
                    Button("Export as SVG...") {}
                        .disabled(true)
                }
            }
    }
}
