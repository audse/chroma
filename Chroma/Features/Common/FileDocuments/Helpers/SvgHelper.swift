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

extension SVGFilter {
    init(filter: LayerFilter) {
        switch filter {
        case .blur(let filter):
            self = SVGFilter.blur(radius: filter.radius)
        case .shadow(let filter):
            self = SVGFilter.shadow(offset: filter.offset, radius: filter.radius, color: filter.color)
        }
    }
}

extension SVGLayer {
    init(layer: LayerModel) {
        let positivePixels = layer.pixels.filter { $0.isPositive }
        let negativePixels = layer.pixels.filter { $0.isNegative }
        self.init(
            positivePixels.map { SVGComponent(pixel: $0) },
            clip: negativePixels.map { SVGComponent(pixel: $0) },
            filters: SVGFilterSet(layer.filters.map { SVGFilter(filter: $0) }),
            style: SVGStyle(
                opacity: layer.opacity,
                blendMode: layer.blendMode
            )
        )
    }
}

extension SVGBuilder {
    init(artboard: ArtboardModel) {
        self.init(
            artboard.backgroundColor,
            artboard.layers.map { layer in SVGLayer(layer: layer) }
        )
    }
}
