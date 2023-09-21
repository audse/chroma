//
//  PointJson.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import Foundation

struct PointJson: Codable {
    var x: Double
    var y: Double

    init(_ cgPoint: CGPoint) {
        self.x = cgPoint.x
        self.y = cgPoint.y
    }
}

extension CGPoint {
    init(_ json: PointJson) {
        self.init(x: json.x, y: json.y)
    }
}
