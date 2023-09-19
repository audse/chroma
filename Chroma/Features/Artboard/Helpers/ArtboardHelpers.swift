//
//  ArtboardHelpers.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI


struct PreviewArtboardModelBuilder {
    var name: String? = "Untitled \(Int.random(in: 1...10))"
    var numberOfLayers: Int = Int.random(in: 1...3)
    var pixelsPerLayer: Int = Int.random(in: 3...10)
    var size: CGSize = CGSize(512)
    var backgroundColor: Color = .random.lighten(0.5)
    
    func build() -> ArtboardModel {
        var layers: [LayerModel] = []
        for index in 0...numberOfLayers {
            var pixels: [PixelModel] = []
            for _ in 0...pixelsPerLayer {
                pixels.append(PreviewPixelBuilder(artboardSize: size).build())
            }
            layers.append(LayerModel(
                name: "Layer \(index)",
                pixels: pixels
            ))
        }
        return ArtboardModel(
            name: name,
            size: size,
            backgroundColor: backgroundColor,
            layers: layers
        )
    }
}
