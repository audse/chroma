//
//  ChromaApp.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

@main
struct ChromaApp: App {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var drawSettings = DrawSettings()
    @StateObject private var currentCanvas = CurrentCanvas().withNewLayer()
    @StateObject private var history = History()
    
    @State private var canvasSize = CGSize(512)
    @State private var canvasBgColor: Color = .white
    @State private var zoom: CGFloat = 1.0
    @State private var tileMode: TileMode = .none
    
    @State private var showingSettings = false
    @State private var isDarkMode = true
    @State private var workspaceBgColor = WorkspaceBgColor.followColorScheme
    
    var body: some Scene {
        WindowGroup("Chroma") {
            ContentView(colorScheme: isDarkMode ? .dark : .light)
//                .onAppear {
//                    isDarkMode = colorScheme == .dark
//                }
                .colorScheme(isDarkMode ? .dark : .light)
                .environmentObject(drawSettings)
                .environmentObject(currentCanvas)
                .environmentObject(history)
                .environment(\.zoom, $zoom)
                .environment(\.tileMode, $tileMode)
                .environment(\.canvasBgColor, $canvasBgColor)
                .environment(\.canvasSize, $canvasSize)
                .environment(\.workspaceBgColor, workspaceBgColor)
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
                        Button {
                            showingSettings = true
                        } label: {
                            Image(systemName: "gear")
                        }
                    }
                }
                .sheet(isPresented: $showingSettings) {
                    Settings(showing: $showingSettings, isDarkMode: $isDarkMode, workspaceBgColor: $workspaceBgColor)
                }
        }
        .windowToolbarStyle(.unifiedCompact(showsTitle: false))
            .commands {
                CommandMenu("Export") {
                    Button("Export as PNG...") {
                        if let url = makeSavePanel([.png]) {
                            savePng(
                                view: CanvasBase()
                                        .environmentObject(currentCanvas)
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
