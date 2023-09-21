//
//  FileModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI
import Combine

class FileModel: ObservableObject, Identifiable {
    @Published var id: UUID
    @Published var name: String
    @Published var artboard: ArtboardModel

    private var _artboardCancellable: AnyCancellable?

    init(
        id: UUID = UUID(),
        name: String = "Untitled",
        artboard: ArtboardModel
    ) {
        self.id = id
        self.name = name
        self.artboard = artboard
        self._subscribe()
    }

    // swiftlint:disable:next identifier_name
    static func Empty(_ name: String = "New Artboard") -> FileModel {
        return FileModel(
            name: name,
            artboard: ArtboardModel().withNewLayer()
        )
    }

    private func _subscribe() {
        _artboardCancellable = artboard.objectWillChange.sink { _ in
            self.objectWillChange.send()
        }
    }

    func setFile(_ file: FileModel) {
        self.id = file.id
        self.name = file.name
        self.artboard = file.artboard
        _subscribe()
    }
}

private struct FileKey: EnvironmentKey {
    static var defaultValue = FileModel.Empty()
}

extension EnvironmentValues {
    var file: FileModel {
        get { self[FileKey.self] }
        set { self[FileKey.self] = newValue }
    }
}
