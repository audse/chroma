//
//  Triangle.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct RightTriangle: InsettableShape {
    var insetAmount: CGFloat = 0

    func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount = amount
        return shape
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: rect.bottomLeft + CGPoint(x: insetAmount, y: -insetAmount))
        path.addLine(to: rect.topRight + CGPoint(x: -insetAmount, y: insetAmount))
        path.addLine(to: rect.end - CGPoint(insetAmount))
        path.closeSubpath()
        return path
    }
}
