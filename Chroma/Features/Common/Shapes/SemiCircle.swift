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

    func path(in rect: CGRect) -> Path {
        let newRect = rect.insetBy(dx: insetAmount, dy: insetAmount)
        var path = Path()
        path.move(to: newRect.bottomLeft)
        path.addArc(
            center: newRect.bottomCenter,
            radius: newRect.width / 2,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 180),
            clockwise: true
        )
        path.addLine(to: newRect.bottomLeft)
        path.closeSubpath()
        return path
    }
}
