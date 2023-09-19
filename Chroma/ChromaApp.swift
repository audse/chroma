//
//  ChromaApp.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct Editor: View {
    @EnvironmentObject private var appSettings: AppSettingsModel
    @EnvironmentObject private var workspaceSettings: WorkspaceSettingsModel
    
    var file: FileModel
    var artboard: ArtboardViewModel
    
    @StateObject private var drawSettings = DrawSettings()
    @StateObject private var history = History()
    
    init(_ file: FileModel) {
        self.file = file
        self.artboard = ArtboardViewModel(file.artboard)
    }
    
    var body: some View {
        ContentView()
            .environmentObject(drawSettings)
            .environmentObject(workspaceSettings)
            .environmentObject(artboard)
            .environmentObject(history)
            .environment(\.file, file)
            .colorScheme(appSettings.colorSchemeValue)
            .frame(idealWidth: 2000, idealHeight: 800)
            .toolbar { toolbar() }
            .sheet(isPresented: appSettings.showingSettingsBinding) {
                AppSettings(showing: appSettings.showingSettingsBinding)
                    .environmentObject(workspaceSettings)
                    .environmentObject(appSettings)
            }
    }
    
    @ToolbarContentBuilder
    func toolbar() -> some ToolbarContent {
        ToolbarItemGroup {
            NavigationLink {
                FilesPage(files: [
                    FileModel(name: "Random 1", artboard: PreviewArtboardModelBuilder().build()),
                    FileModel(name: "Random 2", artboard: PreviewArtboardModelBuilder().build()),
                    FileModel(name: "Random 3", artboard: PreviewArtboardModelBuilder().build()),
                    FileModel(name: "Random 4", artboard: PreviewArtboardModelBuilder().build()),
                ], onSelectFile: { file in
                    history.clear()
                    artboard.setModel(file.artboard)
                }).expand()
                    .colorScheme(appSettings.colorSchemeValue)
                    .environmentObject(artboard)
                
            } label: {
                Label("Files", systemImage: "folder.fill")
                    .labelStyle(.titleAndIcon)
            }
            Spacer()
            Text(file.name)
            Spacer()
            ZoomButtons().environmentObject(workspaceSettings)
            Button {
                appSettings.showingSettings = true
            } label: {
                Image(systemName: "gear")
            }
        }
    }
}

@main
struct ChromaApp: App {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var appSettings = AppSettingsModel()
    @StateObject private var workspaceSettings = WorkspaceSettingsModel()
    
    var body: some Scene {
        WindowGroup("Chroma") {
            NavigationStack {
                Editor(FileModel(
                    id: UUID(),
                    name: "New Artboard",
                    artboard: ArtboardModel()
                ))
            }
            .environmentObject(appSettings)
            .environmentObject(workspaceSettings)
        }
        .windowToolbarStyle(.unifiedCompact(showsTitle: false))
            .commands {
                CommandGroup(after: .appSettings) {
                    Button("Settings") { appSettings.showingSettings.toggle() }
                }
                CommandMenu("Export") {
                    Button("Export as PNG...") {
                        if let url = makeSavePanel([.png]) {
//                            savePng(
//                                view: Artboard(artboard: ArtboardViewModel(file.artboard)),
//                                url: url
//                            )
                        }
                    }
                    Button("Export as SVG...") {}
                        .disabled(true)
                }
            }
    }
}
