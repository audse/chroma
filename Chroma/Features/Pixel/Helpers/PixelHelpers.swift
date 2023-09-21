//
//  PixelHelpers.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI

struct PreviewPixelBuilder {
    var artboardSize: CGSize = CGSize(512)
    var size: CGFloat = [32, 64, 128].randomElement() ?? 32
    var possibleSizes: [CGFloat] = [32, 64, 64, 128, 128, 128]
    var possibleAngles: [CGFloat] = [0, 90, 180, 270, 360]

    func randomPosition() -> CGPoint {
        return CGPoint(
            x: round(CGFloat.random(in: 0...artboardSize.width) / size) * size,
            y: round(CGFloat.random(in: 0...artboardSize.height) / size) * size
        )
    }

    func build() -> PixelModel {
        return PixelModel(
            shape: AllDrawShapes.random(),
            color: Color.random,
            size: possibleSizes.randomElement() ?? 32,
            rotation: Angle(degrees: possibleAngles.randomElement() ?? 0),
            position: randomPosition()
        )
    }
}
