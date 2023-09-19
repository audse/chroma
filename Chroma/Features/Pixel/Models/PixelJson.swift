//
//  PixelJson.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI

struct PixelJson: Identifiable, Decodable {
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
    init(_ json: PixelJson) {
        self.id = json.id
        self.shape = AllDrawShapes.find(by: json.shapeId) ?? SquareShape
        self.color = Color(json.color)
        self.size = json.size
        self.rotation = Angle(json.rotation)
        self.position = CGPoint(json.position)
    }
}
