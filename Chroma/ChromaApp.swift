//
//  ChromaApp.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

public func getSavedProperty<T>(key: String, defaultValue: T) -> T where T: Codable {
    if let data = UserDefaults.standard.data(forKey: key) {
        if let decoded = try? JSONDecoder().decode(T.self, from: data) {
            return decoded
        }
    }
    return defaultValue
}

public func saveProperty<T>(key: String, value: T) where T: Codable {
    if let encoded = try? JSONEncoder().encode(value) {
        UserDefaults.standard.set(encoded, forKey: key)
    }
}

struct Editor: View {
    @EnvironmentObject private var appSettings: AppSettingsModel
    @EnvironmentObject private var workspaceSettings: WorkspaceSettingsModel

    @StateObject var file: FileModel
    @StateObject private var drawSettings = DrawSettings()
    @StateObject private var history = History()

    var body: some View {
        ContentView()
            .environmentObject(drawSettings)
            .environmentObject(workspaceSettings)
            .environmentObject(file.artboard)
            .environmentObject(history)
            .environmentObject(file)
            .if(appSettings.colorSchemeValue != nil) { view in
                view.colorScheme(appSettings.colorSchemeValue ?? .light)
            }
            .toolbar { toolbar() }
            .sheet(isPresented: $appSettings.showingSettings) {
                AppSettings(showing: $appSettings.showingSettings)
                    .environmentObject(workspaceSettings)
                    .environmentObject(appSettings)
            }
            .sheet(isPresented: $appSettings.showingExport) {
                ExportPage(showing: $appSettings.showingExport)
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
                        let newFile: FileModel? = load(url[0])
                        if let newFile = newFile {
                            file.setFile(newFile)
                        }
                    case .failure(let error): print(error)
                    }
                }
            )
            .onAppear {
                if let layer = file.artboard.layers.first {
                    history.add(SelectLayerAction(layer))
                }
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
                    FileModel(name: "Random 4", artboard: PreviewArtboardModelBuilder().build())
                ], onSelectFile: { newFile in
                    history.clear()
                    file.setFile(newFile)
                }).expand()
                    .if(appSettings.colorSchemeValue != nil) { view in
                        view.colorScheme(appSettings.colorSchemeValue ?? .light)
                    }
                    .environmentObject(file)
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
    @StateObject private var history = History()

    @StateObject private var emptyFile = FileModel.Empty()

    var body: some Scene {
        WindowGroup("Chroma") {
            NavigationStack {
                Editor(file: emptyFile)
            }
            .environmentObject(appSettings)
            .environmentObject(workspaceSettings)
        }
        .windowResizability(.automatic)
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
                CommandGroup(replacing: .undoRedo) {
                    Button("Undo") {
                        RequestUndoEvent.emit(())
                    }
                    .keyboardShortcut("z", modifiers: [.command])
                    Button("Redo") {
                        RequestRedoEvent.emit(())
                    }
                    .keyboardShortcut("z", modifiers: [.command, .shift])
                }
            }
    }
}
