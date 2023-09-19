//
//  FileModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI

struct FileModel: Identifiable {
    var id: UUID = UUID()
    var name: String = "Untitled"
    var artboard: ArtboardModel
}


private struct FileKey: EnvironmentKey {
    static var defaultValue = FileModel(
        name: "New Artboard",
        artboard: ArtboardModel()
    )
}

extension EnvironmentValues {
    var file: FileModel {
        get { self[FileKey.self] }
        set { self[FileKey.self] = newValue }
    }
}
