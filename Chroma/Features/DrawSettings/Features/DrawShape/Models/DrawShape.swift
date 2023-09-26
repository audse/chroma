//
//  PixelShape.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

public struct DrawShape: Identifiable {
    public let id: String
    public let shape: AnyShape
    public let aspectRatio: (CGFloat, CGFloat)
    public let keyboardShortcut: KeyEquivalent?
}

extension DrawShape: Codable {
    internal enum CodingKeys: CodingKey {
        case id
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let id = try values.decode(String.self, forKey: .id)
        self = AllDrawShapes.find(by: id) ?? SquareShape
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
    }
}

// swiftlint:disable identifier_name

public let SquareShape = DrawShape(
    id: "Square",
    shape: AnyShape(Square()),
    aspectRatio: (1, 1),
    keyboardShortcut: "1"
)
public let CircleShape = DrawShape(
    id: "Circle",
    shape: AnyShape(Circle()),
    aspectRatio: (1, 1),
    keyboardShortcut: "2"
)
public let SemiCircleShape = DrawShape(
    id: "Semi Circle",
    shape: AnyShape(SemiCircle()),
    aspectRatio: (1, 0.5),
    keyboardShortcut: "3"
)
public let QuadrantShape = DrawShape(
    id: "Quadrant",
    shape: AnyShape(Quadrant()),
    aspectRatio: (1, 1),
    keyboardShortcut: "4"
)
public let RightTriangleShape = DrawShape(
    id: "Right Triangle",
    shape: AnyShape(RightTriangle()),
    aspectRatio: (1, 1),
    keyboardShortcut: "5"
)
public let InverseQuadrantShape = DrawShape(
    id: "Inverse Quadrant",
    shape: AnyShape(InverseQuadrant()),
    aspectRatio: (1, 1),
    keyboardShortcut: "6"
)

// swiftlint:enable identifier_name

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
