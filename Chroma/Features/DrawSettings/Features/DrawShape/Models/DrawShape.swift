//
//  PixelShape.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct DrawShape: Identifiable {
    public var id: String
    public var shape: AnyShape
}

let SquareShape = DrawShape(id: "Square", shape: AnyShape(Square()))
let CircleShape = DrawShape(id: "Circle", shape: AnyShape(Circle()))
let SemiCircleShape = DrawShape(id: "Semi Circle", shape: AnyShape(SemiCircle()))
let QuadrantShape = DrawShape(id: "Quadrant", shape: AnyShape(Quadrant()))
let RightTriangleShape = DrawShape(id: "Right Triangle", shape: AnyShape(RightTriangle()))
let InverseQuadrantShape = DrawShape(id: "Inverse Quadrant", shape: AnyShape(InverseQuadrant()))
