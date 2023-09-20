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
    public var keyboardShortcut: KeyEquivalent?
}

let SquareShape = DrawShape(
    id: "Square",
    shape: AnyShape(Square()),
    keyboardShortcut: "1"
)
let CircleShape = DrawShape(
    id: "Circle",
    shape: AnyShape(Circle()),
    keyboardShortcut: "2"
)
let SemiCircleShape = DrawShape(
    id: "Semi Circle",
    shape: AnyShape(SemiCircle()),
    keyboardShortcut: "3"
)
let QuadrantShape = DrawShape(
    id: "Quadrant",
    shape: AnyShape(Quadrant()),
    keyboardShortcut: "4"
)
let RightTriangleShape = DrawShape(
    id: "Right Triangle",
    shape: AnyShape(RightTriangle()),
    keyboardShortcut: "5"
)
let InverseQuadrantShape = DrawShape(
    id: "Inverse Quadrant",
    shape: AnyShape(InverseQuadrant()),
    keyboardShortcut: "6"
)


struct AllDrawShapes {
    static var shapes: [DrawShape] = [
        SquareShape,
        CircleShape,
        SemiCircleShape,
        QuadrantShape,
        RightTriangleShape,
        InverseQuadrantShape
    ]
    
    mutating func add(_ shape: DrawShape) {
        AllDrawShapes.shapes.append(shape)
    }
    
    static func find(by id: String) -> DrawShape? {
        return AllDrawShapes.shapes.first(where: { shape in shape.id == id })
    }
    
    static func random() -> DrawShape {
        return AllDrawShapes.shapes.randomElement() ?? SquareShape
    }
}

