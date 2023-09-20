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
    
    init() {
        id = UUID()
        name = "Blank file"
        artboard = ArtboardJson(ArtboardModel())
    }
    
    init(_ model: FileModel) {
        self.id = model.id
        self.name = model.name
        self.artboard = ArtboardJson(model.artboard)
    }
}

extension FileModel {
    init(_ json: FileJson) {
        self.id = json.id
        self.name = json.name
        self.artboard = ArtboardModel(json.artboard)
    }
}
