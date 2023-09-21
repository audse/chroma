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
