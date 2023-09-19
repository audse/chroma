//
//  ArtboardModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

struct ArtboardModel {
    var id: UUID = UUID()
    var name: String? = nil
    var size: CGSize = CGSize(512)
    var backgroundColor: Color = .white
    var layers: [LayerModel] = []
}
