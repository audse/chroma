//
//  FileJson.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct FileJson: Identifiable, Codable {
    var id: UUID
    var name: String
    var artboard: ArtboardJson
    
    init(_ model: FileModel) {
        self.id = model.id
        self.name = model.name
        self.artboard = ArtboardJson(model.artboard)
    }
    
    static func Empty() -> FileJson {
        return FileJson(FileModel(
            id: UUID(),
            name: "Untitled",
            artboard: ArtboardModel()
        ))
    }
}

extension FileModel {
    convenience init(_ json: FileJson) {
        self.init(
            id: json.id,
            name: json.name,
            artboard: ArtboardModel(json.artboard)
        )
    }
}
