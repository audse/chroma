//
//  InverseQuadrant.swift
//  Chroma
//
//  Created by Audrey Serene on 9/15/23.
//

import SwiftUI

struct InverseQuadrant: InsettableShape {
    var insetAmount: CGFloat = 0

    func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount = amount
        return shape
    }

    func path(in rect: CGRect) -> Path {
        let sideLength = min(rect.width, rect.height) - (insetAmount * 2)
        var path = Path()
        path.move(to: rect.topRight + CGPoint(x: -insetAmount, y: insetAmount))
        path.addRelativeArc(
            center: rect.origin + CGPoint(insetAmount),
            radius: sideLength,
            startAngle: Angle(degrees: 0),
            delta: Angle(degrees: 90)
        )
        path.addLine(to: rect.end - CGPoint(insetAmount))
        path.closeSubpath()
        return path
    }
}
