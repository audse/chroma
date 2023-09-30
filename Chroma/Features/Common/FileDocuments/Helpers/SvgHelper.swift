//
//  SvgHelper.swift
//  Chroma
//
//  Created by Audrey Serene on 9/28/23.
//

import SwiftUI
import Extensions
import SVG

extension SVGTag {
    init(pixel: PixelModel) {
        let rect = pixel.getRect()
        var attributes = SVGAttributeSet()
        attributes.add(fill: pixel.color)
        attributes.add(rotation: .rotation(pixel.rotation, origin: rect.center))
        self.init(
            from: pixel.shape.shape,
            in: rect,
            attributes: attributes
        )
    }
    init(pixel: LayerPixelModel) {
        let fill: Color = switch pixel {
        case .positive(let pixel): pixel.color
        default: .black
        }
        let rect = pixel.getRect()
        var attributes = SVGAttributeSet()
        attributes.add(fill: fill)
        attributes.add(rotation: .rotation(pixel.pixel.rotation, origin: rect.center))
        self.init(
            from: pixel.pixel.shape.shape,
            in: rect,
            attributes: attributes
        )
    }
}

extension SVGFilter {
    init(filter: LayerFilter) {
        switch filter {
        case .blur(let filter):
            self = .blur(radius: filter.radius)
        case .shadow(let filter):
            self = .shadow(offset: filter.offset, radius: filter.radius, color: filter.color)
        }
    }
}

extension SVGLayer {
    init(layer: LayerModel) {
        var attributes = SVGAttributeSet([
            .init("opacity", .number(layer.opacity))
        ])
        attributes.add(blendMode: layer.blendMode)
        let positivePixels = layer.pixels.filter { $0.isPositive }
        let negativePixels = layer.pixels.filter { $0.isNegative }
        self.init(
            positivePixels.map { SVGTag(pixel: $0) },
            clip: negativePixels.map { SVGTag(pixel: $0) },
            filters: SVGFilterSet(layer.filters.map { SVGFilter(filter: $0) }),
            attributes: attributes
        )
    }
}

extension SVG {
    init(artboard: ArtboardModel) {
        self.init(
            artboard.backgroundColor,
            artboard.layers.filter { $0.isVisible }.map { layer in SVGLayer(layer: layer) }
        )
    }
}
