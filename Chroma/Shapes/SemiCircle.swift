//
//  SemiCircle.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct SemiCircle: InsettableShape {
    var insetAmount: CGFloat = 0
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount = amount
        return shape
    }
    
    func getCenter(_ rect: CGRect) -> CGPoint {
        return rect.origin + CGPoint(x: rect.width / 2, y: rect.height) + CGPoint(x: 0, y: -insetAmount)
    }
    
    func path(in rect: CGRect) -> Path {
        let sideLength = min(rect.width, rect.height) / 2 - insetAmount
        let startPosition = rect.origin + CGPoint(x: 0, y: rect.height) + CGPoint(x: insetAmount, y: -insetAmount)
        var p = Path()
        p.move(to: startPosition)
        p.addArc(
            center: getCenter(rect),
            radius: sideLength,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 180),
            clockwise: true
        )
        p.addLine(to: startPosition)
        p.closeSubpath()
        return p
    }
}
