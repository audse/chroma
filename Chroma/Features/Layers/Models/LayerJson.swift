//
//  LayerJson.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import Foundation

struct LayerJson: Identifiable, Codable {
    var id = UUID()
    var name = "Layer"
    var pixels: [LayerPixelJson] = []
    var isVisible: Bool = true

    init(_ model: LayerModel) {
        self.id = model.id
        self.name = model.name
        self.pixels = model.pixels.map { pixel in LayerPixelJson(pixel) }
        self.isVisible = model.isVisible
    }
}

extension LayerModel {
    convenience init(_ json: LayerJson) {
        self.init(
            id: json.id,
            name: json.name,
            pixels: json.pixels.map { pixel in LayerPixelModel(pixel) },
            isVisible: json.isVisible
        )
    }
}
