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
        let startPosition = rect.origin + CGPoint(x: 0, y: rect.height) + CGPoint(x: insetAmount, y: -insetAmount)
        var path = Path()
        path.move(to: startPosition)
        path.addArc(
            center: getCenter(rect),
            radius: (rect.width - insetAmount * 2) / 2,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 180),
            clockwise: true
        )
        path.addLine(to: startPosition)
        path.closeSubpath()
        return path
    }
}
