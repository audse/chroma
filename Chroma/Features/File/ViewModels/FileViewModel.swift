//
//  FileViewModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/19/23.
//

import SwiftUI
import Combine


class FileViewModel: ObservableObject {
    @Published var file: FileModel
    @Published var artboard: ArtboardViewModel
    
    private var _cancellable: AnyCancellable? = nil
    
    init(_ file: FileModel) {
        self.file = file
        self.artboard = ArtboardViewModel(file.artboard)
        self._cancellable = self.artboard.objectWillChange.sink(receiveValue: {
            self.objectWillChange.send()
        })
    }
}

private struct FileKey: EnvironmentKey {
    static var defaultValue = FileViewModel(FileModel(
        name: "New Artboard",
        artboard: ArtboardModel()
    ))
}

extension EnvironmentValues {
    var file: FileViewModel {
        get { self[FileKey.self] }
        set { self[FileKey.self] = newValue }
    }
}
