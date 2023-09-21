//
//  ArtboardJson.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI

struct ArtboardJson: Identifiable, Codable {
    var id: UUID
    var name: String?
    var size: SizeJson
    var backgroundColor: ColorJson
    var layers: [LayerJson]
    
    init(_ model: ArtboardModel) {
        self.id = model.id
        self.name = model.name
        self.size = SizeJson(model.size)
        self.backgroundColor = ColorJson(model.backgroundColor)
        self.layers = model.layers.map { layer in LayerJson(layer) }
    }
}

extension ArtboardModel {
    convenience init(_ json: ArtboardJson) {
        self.init(
            id: json.id,
            name: json.name,
            size: CGSize(json.size),
            backgroundColor: Color(json.backgroundColor),
            layers: json.layers.map { layer in LayerModel(layer) }
        )
    }
}
