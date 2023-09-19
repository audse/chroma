//
//  PixelModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI

struct PixelModel: Identifiable {
    var id: UUID = UUID()
    var shape: DrawShape = SquareShape
    var color: Color = .red
    var size: CGFloat = 32
    var rotation = Angle(degrees: 0)
    var position = CGPoint()
}
