//
//  EditorView.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI
import Combine

struct EditorView: View, Identifiable {
    let id = UUID()
    
    @Environment(\.openDocument) var openDocument
    @EnvironmentObject var appSettings: AppSettingsModel
    @EnvironmentObject var file: FileModel
    
    @StateObject private var workspaceSettings = WorkspaceSettingsModel()
    @StateObject private var history = History()
    @StateObject private var drawSettings = DrawSettings()
    @StateObject private var editorState = EditorState()
    
    var body: some View {
        let bindings = editorState.getBindings()
        ZStack {
            // Quick export
            PngExporter(isPresented: bindings.quickFileExport.png, exportScale: .constant(1))
            SvgExporter(isPresented: bindings.quickFileExport.svg)
            ArtboardWrapper()
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    PixelSizeControl().panel()
                    DrawColorControl().panel()
                    
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
            isPresented: bindings.fileImport,
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
        .if(appSettings.colorSchemeValue != nil) { view in
            view.colorScheme(appSettings.colorSchemeValue ?? .light)
        }
        .toolbar { editorToolbar() }
        .sheet(isPresented: bindings.settings) {
            AppSettings(showing: bindings.settings)
                .environmentObject(workspaceSettings)
                .environmentObject(appSettings)
        }
        .sheet(isPresented: bindings.fileExport) {
            ExportPage(showing: bindings.fileExport)
                .environmentObject(file)
                .environmentObject(appSettings)
        }
        .sheet(isPresented: bindings.documentation) {
            DocumentationPage(showing: bindings.documentation)
                .frame(minWidth: 800, minHeight: 600)
        }
        .environmentObject(drawSettings)
        .environmentObject(history)
        .environmentObject(workspaceSettings)
        .focusedSceneValue(\.editorState, editorState)
        .onAppear {
            if let layer = file.artboard.layers.first {
                history.add(SelectLayerAction(layer))
            }
            Task {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.125) {
                    releaseFocus()
                }
            }
        }
        .onKeyPressEvent("g") {
            workspaceSettings.gridMode =
                switch workspaceSettings.gridMode {
                case .none: .dots
                case .dots: .lines
                case .lines: .none
                }
        }
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
                editorState.showingModal = .settings
            } label: {
                Image(systemName: "gear")
            }
        }
    }
}

struct EditorCommands: Commands {
    @FocusedValue(\.editorState) var editorState
    
    var body: some Commands {
        CommandGroup(after: .appSettings) {
            Button("Settings") {
                editorState?.showingModal = .settings
            }.keyboardShortcut(",", modifiers: .command)
        }
        CommandGroup(replacing: .pasteboard) {
            Button("Cut") {
                RequestCut.emit(())
            }.keyboardShortcut("x", modifiers: .command)
            Button("Copy") {
                RequestCopy.emit(())
            }.keyboardShortcut("c", modifiers: .command)
            Button("Paste") {
                RequestPaste.emit(())
            }.keyboardShortcut("v", modifiers: .command)
        }
        CommandGroup(after: .importExport) {
            Button("Export...") {
                editorState?.showingModal = .fileExport
            }.keyboardShortcut("e", modifiers: .command)
        }
        CommandGroup(after: .importExport) {
            Button("Quick Export as PNG") {
                editorState?.showingModal = .quickFileExport(.png)
            }.keyboardShortcut("1", modifiers: [.command, .shift])
        }
        CommandGroup(after: .importExport) {
            Button("Quick Export as SVG") {
                editorState?.showingModal = .quickFileExport(.svg)
            }.keyboardShortcut("2", modifiers: [.command, .shift])
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
        CommandMenu("Select") {
            Button("Select All") {
                RequestSelectAll.emit(())
            }.keyboardShortcut("a", modifiers: [.command])
            Button("Deselect") {
                RequestDeselectAll.emit(())
            }.keyboardShortcut("d", modifiers: [.command])
        }
        CommandGroup(replacing: .help) {
            Button("Documentation") {
                editorState?.showingModal = .documentation
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
