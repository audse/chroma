//
//  SvgHelper.swift
//  Chroma
//
//  Created by Audrey Serene on 9/28/23.
//

import SwiftUI
import Extensions
import SVG

extension SVGComponent {
    init(pixel: PixelModel) {
        self.init(
            pixel.shape.shape,
            in: pixel.getRect(),
            style: SVGStyle(fill: pixel.color, rotation: pixel.rotation)
        )
    }
    init(pixel: LayerPixelModel) {
        let fill: Color = switch pixel {
        case .positive(let pixel): pixel.color
        default: .black
        }
        self.init(
            pixel.pixel.shape.shape,
            in: pixel.getRect(),
            style: SVGStyle(fill: fill, rotation: pixel.pixel.rotation)
        )
    }
}

extension SVGLayer {
    init(layer: LayerModel) {
        let positivePixels = layer.pixels.filter { $0.isPositive }
        let negativePixels = layer.pixels.filter { $0.isNegative }
        self.init(
            positivePixels.map { pixel in SVGComponent(pixel: pixel) },
            clip: negativePixels.map { pixel in SVGComponent(pixel: pixel) },
            style: SVGStyle(
                opacity: layer.opacity,
                blendMode: layer.blendMode
            )
        )
    }
}

extension SVGBuilder {
    init(artboard: ArtboardModel) {
        self.init(artboard.layers.map { layer in SVGLayer(layer: layer) })
    }
}
