//
//  PixelShape.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct PixelShape: Identifiable {
    public var id: String
    public var shape: AnyShape
}

let SquareShape = PixelShape(id: "Square", shape: AnyShape(Square()))
let CircleShape = PixelShape(id: "Circle", shape: AnyShape(Circle()))
let SemiCircleShape = PixelShape(id: "Semi Circle", shape: AnyShape(SemiCircle()))
let QuadrantShape = PixelShape(id: "Quadrant", shape: AnyShape(Quadrant()))
let RightTriangleShape = PixelShape(id: "Right Triangle", shape: AnyShape(RightTriangle()))
let InverseQuadrantShape = PixelShape(id: "Inverse Quadrant", shape: AnyShape(InverseQuadrant()))
