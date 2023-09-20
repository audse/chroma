//
//  ChromaApp.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

func releaseFocus() {
    NSApp.keyWindow?.makeFirstResponder(nil)
}

struct Editor: View {
    @EnvironmentObject private var appSettings: AppSettingsModel
    @EnvironmentObject private var workspaceSettings: WorkspaceSettingsModel
    
    @StateObject var file: FileViewModel    
    @StateObject private var drawSettings = DrawSettings()
    @StateObject private var history = History()
    
    var body: some View {
        ContentView()
            .environmentObject(drawSettings)
            .environmentObject(workspaceSettings)
            .environmentObject(file.artboard)
            .environmentObject(history)
            .environmentObject(file)
            .colorScheme(appSettings.colorSchemeValue)
            .frame(idealWidth: 2000, idealHeight: 800)
            .toolbar { toolbar() }
            .sheet(isPresented: appSettings.showingSettingsBinding) {
                AppSettings(showing: appSettings.showingSettingsBinding)
                    .environmentObject(workspaceSettings)
                    .environmentObject(appSettings)
            }
            .sheet(isPresented: appSettings.showingExportBinding) {
                ExportPage(showing: appSettings.showingExportBinding)
                    .environmentObject(file)
                    .environmentObject(appSettings)
                    .environmentObject(file.artboard)
            }
            .fileImporter(
                isPresented: $appSettings.showingImport,
                allowedContentTypes: [.chroma, .json],
                allowsMultipleSelection: false,
                onCompletion: { result in
                    switch result {
                        case .success(let url):
                            let newFile: FileJson? = load(url[0])
                            if let newFile = newFile { file.setFile(FileModel(newFile)) }
                        case .failure(let error): print(error)
                    }
                }
            )
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
                ], onSelectFile: { newFile in
                    history.clear()
                    file.artboard.setModel(newFile.artboard)
                }).expand()
                    .colorScheme(appSettings.colorSchemeValue)
                    .environmentObject(file)
            } label: {
                Label("Files", systemImage: "folder.fill")
                    .labelStyle(.titleAndIcon)
            }
            Spacer()
            Text(file.file.name)
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
                Editor(file: FileViewModel(FileModel(
                    id: UUID(),
                    name: "New Artboard",
                    artboard: ArtboardModel(
                        layers: [LayerModel()]
                    )
                )))
            }
            .environmentObject(appSettings)
            .environmentObject(workspaceSettings)
        }
        .windowToolbarStyle(.unifiedCompact(showsTitle: false))
            .commands {
                CommandGroup(after: .appSettings) {
                    Button("Settings") {
                        appSettings.showingSettings.toggle()
                    }.keyboardShortcut(",", modifiers: .command)
                }
                CommandGroup(after: .newItem) {
                    Button("Open...") {
                        appSettings.showingImport.toggle()
                    }.keyboardShortcut("o", modifiers: .command)
                }
                CommandGroup(after: .importExport) {
                    Button("Export...") {
                        appSettings.showingExport.toggle()
                    }.keyboardShortcut("e", modifiers: .command)
                }
            }
    }
}
