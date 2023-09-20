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
