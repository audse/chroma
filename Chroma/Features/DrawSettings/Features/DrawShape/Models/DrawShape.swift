//
//  PixelShape.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

public struct DrawShape: Identifiable {
    public var id: String
    public var shape: AnyShape
    public var keyboardShortcut: KeyEquivalent?
}

public let SquareShape = DrawShape(
    id: "Square",
    shape: AnyShape(Square()),
    keyboardShortcut: "1"
)
public let CircleShape = DrawShape(
    id: "Circle",
    shape: AnyShape(Circle()),
    keyboardShortcut: "2"
)
public let SemiCircleShape = DrawShape(
    id: "Semi Circle",
    shape: AnyShape(SemiCircle()),
    keyboardShortcut: "3"
)
public let QuadrantShape = DrawShape(
    id: "Quadrant",
    shape: AnyShape(Quadrant()),
    keyboardShortcut: "4"
)
public let RightTriangleShape = DrawShape(
    id: "Right Triangle",
    shape: AnyShape(RightTriangle()),
    keyboardShortcut: "5"
)
public let InverseQuadrantShape = DrawShape(
    id: "Inverse Quadrant",
    shape: AnyShape(InverseQuadrant()),
    keyboardShortcut: "6"
)


public struct AllDrawShapes {
    static public var shapes: [DrawShape] = [
        SquareShape,
        CircleShape,
        SemiCircleShape,
        QuadrantShape,
        RightTriangleShape,
        InverseQuadrantShape
    ]
    
    public mutating func add(_ shape: DrawShape) {
        AllDrawShapes.shapes.append(shape)
    }
    
    public static func find(by id: String) -> DrawShape? {
        return AllDrawShapes.shapes.first(where: { shape in shape.id == id })
    }
    
    public static func random() -> DrawShape {
        return AllDrawShapes.shapes.randomElement() ?? SquareShape
    }
}

