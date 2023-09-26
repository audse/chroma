//
//  RegularPolygon.swift
//  Chroma
//
//  Created by Audrey Serene on 9/25/23.
//

import SwiftUI

public struct Polygon: Shape {
    let sides: UInt
    private let inset: CGFloat

    public func path(in rect: CGRect) -> Path {
        Path.regularPolygon(sides: self.sides, in: rect, inset: inset)
    }
    
    public init(sides: UInt) {
        self.init(sides: sides, inset: 0)
    }
    
    init(sides: UInt, inset: CGFloat) {
        self.sides = sides
        self.inset = inset
    }
}

extension Polygon: InsettableShape {
    public func inset(by amount: CGFloat) -> Polygon {
        Polygon(sides: self.sides, inset: self.inset + amount)
    }
}
