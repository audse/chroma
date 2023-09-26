//
//  EditorView.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct EditorView: View {
    @Environment(\.openDocument) var openDocument
    @EnvironmentObject var appSettings: AppSettingsModel
    @EnvironmentObject var file: FileModel
    
    @StateObject private var workspaceSettings = WorkspaceSettingsModel()
    @StateObject private var history = History()
    @StateObject private var drawSettings = DrawSettings()

    var body: some View {
        ZStack {
            // Quick PNG export
            PngExporter(isPresented: $appSettings.showingPngQuickExport, exportScale: .constant(1))
            ArtboardWrapper()
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    PixelSizeControl().panel()
                    ColorControl().panel()
                    ToolList()
                    VStack {
                        HistoryButtons()
                        HistoryList().expandHeight()
                    }.panel()
                }
                Spacer()
                HStack(alignment: .top) {
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
        .fileImporter(
            isPresented: $appSettings.showingImport,
            allowedContentTypes: [.chroma],
            allowsMultipleSelection: false,
            onCompletion: { result in
                switch result {
                case .success(let urls):
                    if let url = urls.first {
                        Task { try await openDocument(at: url) }
                    }
                case .failure(let error): print(error)
                }
            }
        )
        .onAppear {
            if let layer = file.artboard.layers.first {
                history.add(SelectLayerAction(layer))
            }
            Task { releaseFocus() }
        }
        .if(appSettings.colorSchemeValue != nil) { view in
            view.colorScheme(appSettings.colorSchemeValue ?? .light)
        }
        .toolbar { editorToolbar() }
        .sheet(isPresented: $appSettings.showingSettings) {
            AppSettings(showing: $appSettings.showingSettings)
                .environmentObject(workspaceSettings)
                .environmentObject(appSettings)
        }
        .sheet(isPresented: $appSettings.showingExport) {
            ExportPage(showing: $appSettings.showingExport)
                .environmentObject(file)
                .environmentObject(appSettings)
        }
        .sheet(isPresented: $appSettings.showingDocumentation) {
            DocumentationPage(showing: $appSettings.showingDocumentation)
                .frame(minWidth: 800, minHeight: 600)
        }
        .environmentObject(drawSettings)
        .environmentObject(history)
        .environmentObject(workspaceSettings)
    }
    
    @ToolbarContentBuilder
    private func editorToolbar() -> some ToolbarContent {
        ToolbarItemGroup {
            Spacer()
            EditableText(text: Binding(get: { file.name }, set: { file.name = $0 }))
                .foregroundColor(.primary)
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

struct EditorCommands: Commands {
    @ObservedObject var appSettings: AppSettingsModel
    
    var body: some Commands {
        CommandGroup(after: .appSettings) {
            Button("Settings") {
                appSettings.showingSettings.toggle()
            }.keyboardShortcut(",", modifiers: .command)
        }
        CommandGroup(after: .importExport) {
            Button("Export...") {
                appSettings.showingExport.toggle()
            }.keyboardShortcut("e", modifiers: .command)
        }
        CommandGroup(after: .importExport) {
            Button("Quick Export as PNG") {
                appSettings.showingPngQuickExport.toggle()
            }.keyboardShortcut("e", modifiers: [.command, .shift])
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
        CommandGroup(replacing: .help) {
            Button("Documentation") {
                appSettings.showingDocumentation.toggle()
            }.keyboardShortcut("h", modifiers: [.command, .shift])
        }
    }
}

#Preview {
    let artboard = ArtboardModel()
    return EditorView()
        .environmentObject(AppSettingsModel())
        .environmentObject(DrawSettings())
        .environmentObject(FileModel(artboard: artboard))
        .environmentObject(History())
        .environmentObject(WorkspaceSettingsModel())
}
