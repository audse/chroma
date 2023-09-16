//
//  Quadrant.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct Quadrant: InsettableShape {
    var insetAmount: CGFloat = 0
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount = amount
        return shape
    }
    
    func path(in rect: CGRect) -> Path {
        let sideLength = min(rect.width, rect.height) - (insetAmount * 2)
        var p = Path()
        p.move(to: rect.bottomLeft + CGPoint(x: insetAmount, y: -insetAmount))
        p.addRelativeArc(
            center: CGPoint(x: rect.width, y: rect.height) - CGPoint(insetAmount),
            radius: sideLength,
            startAngle: Angle(degrees: 180),
            delta: Angle(degrees: 90)
        )
        p.addLine(to: rect.end - CGPoint(insetAmount))
        p.closeSubpath()
        return p
    }
}
