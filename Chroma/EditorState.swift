//
//  EditorState.swift
//  Chroma
//
//  Created by Audrey Serene on 9/29/23.
//

import SwiftUI

enum EditorModal: Equatable {
    case none
    case settings
    case fileImport
    case fileExport
    case quickFileExport(ExportType)
    case documentation
}

class EditorState: ObservableObject {
    @Published var focusedWindow: NSWindow?
    @Published var showingModal: EditorModal = .none
    
    func getBindingToModal(_ modal: EditorModal) -> Binding<Bool> {
        Binding(
            get: { self.showingModal == modal },
            set: { _ in self.showingModal = .none }
        )
    }
    
    func getBindings() -> (
        settings: Binding<Bool>,
        fileImport: Binding<Bool>,
        fileExport: Binding<Bool>,
        quickFileExport: (
            png: Binding<Bool>,
            svg: Binding<Bool>
        ),
        documentation: Binding<Bool>
    ) {
        return (
            settings: getBindingToModal(.settings),
            fileImport: getBindingToModal(.fileImport),
            fileExport: getBindingToModal(.fileExport),
            quickFileExport: (
                png: getBindingToModal(.quickFileExport(.png)),
                svg: getBindingToModal(.quickFileExport(.svg))
            ),
            documentation: getBindingToModal(.documentation)
        )
    }
}

struct EditorStateKey: FocusedValueKey {
  typealias Value = EditorState
}

extension FocusedValues {
  var editorState: EditorState? {
    get { self[EditorStateKey.self] }
    set { self[EditorStateKey.self] = newValue }
  }
}
