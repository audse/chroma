//
//  PixelJson.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI

struct PixelJson: Identifiable, Codable {
    var id: UUID
    var shapeId: String
    var color: ColorJson
    var size: Double
    var rotation: AngleJson
    var position: PointJson

    init(_ pixel: PixelModel) {
        id = pixel.id
        shapeId = pixel.shape.id
        color = ColorJson(pixel.color)
        size = pixel.size
        rotation = AngleJson(pixel.rotation)
        position = PointJson(pixel.position)
    }
}

extension PixelModel {
    convenience init(_ json: PixelJson) {
        self.init(
            id: json.id,
            shape: AllDrawShapes.find(by: json.shapeId) ?? SquareShape,
            color: Color(json.color),
            size: json.size,
            rotation: Angle(json.rotation),
            position: CGPoint(json.position)
        )
    }
}

enum LayerPixelJson: Identifiable, Codable {
    case positive(PixelJson)
    case negative(PixelJson)
    
    var pixel: PixelJson {
        switch self {
        case .positive(let pixel): return pixel
        case .negative(let pixel): return pixel
        }
    }
    
    var id: UUID {
        return pixel.id
    }
    
    init(_ model: LayerPixelModel) {
        switch model {
        case .positive(let pixel): self = .positive(PixelJson(pixel))
        case .negative(let pixel): self = .negative(PixelJson(pixel))
        }
    }
}

extension LayerPixelModel {
    init(_ json: LayerPixelJson) {
        switch json {
        case .positive(let json): self = .positive(PixelModel(json))
        case .negative(let json): self = .negative(PixelModel(json))
        }
    }
}
