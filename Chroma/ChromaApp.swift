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
    @StateObject private var appSettings = AppSettingsModel()
    @StateObject private var drawSettings = DrawSettings()
    @StateObject private var workspaceSettings = WorkspaceSettingsModel()
    @StateObject private var currentArtboard = CurrentArtboardViewModel().withNewLayer()
    @StateObject private var history = History()
    
    @State private var showingSettings = false
    
    var body: some Scene {
        WindowGroup("Chroma") {
            ContentView()
//                .onAppear {
//                    isDarkMode = colorScheme == .dark
//                }
                .environmentObject(appSettings)
                .environmentObject(drawSettings)
                .environmentObject(workspaceSettings)
                .environmentObject(currentArtboard)
                .environmentObject(history)
                .colorScheme(appSettings.colorSchemeValue)
                .frame(idealWidth: 2000, idealHeight: 800)
                .toolbar {
                    ToolbarItemGroup {
                        Button {} label: {
                            Image(systemName: "chevron.left")
                        }.buttonStyle(.plain)
                        Spacer()
                        Text("New Canvas")
                        Spacer()
                        ZoomButtons().environmentObject(workspaceSettings)
                        Button {
                            showingSettings = true
                        } label: {
                            Image(systemName: "gear")
                        }
                    }
                }
                .sheet(isPresented: $showingSettings) {
                    AppSettings(
                        showing: $showingSettings
                    ).environmentObject(workspaceSettings)
                        .environmentObject(appSettings)
                }
        }
        .windowToolbarStyle(.unifiedCompact(showsTitle: false))
            .commands {
                CommandGroup(after: .appSettings) {
                    Button("Settings") {
                        showingSettings.toggle()
                    }
                }
                CommandMenu("Export") {
                    Button("Export as PNG...") {
                        if let url = makeSavePanel([.png]) {
                            savePng(
                                view: Artboard().environmentObject(currentArtboard),
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
