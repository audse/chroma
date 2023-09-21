//
//  DotsGridPattern.swift
//  Chroma
//
//  Created by Audrey Serene on 9/20/23.
//

import SwiftUI

public struct DotsGridPattern: InsettableShape {
    private let inset: CGFloat
    private let horizontalDots: Int
    private let verticalDots: Int
    private let radius: CGFloat

    public func inset(by amount: CGFloat) -> DotsGridPattern {
        DotsGridPattern(
            inset: self.inset + amount,
            horizontalDots: self.horizontalDots,
            verticalDots: self.verticalDots
        )
    }

    public func path(in rect: CGRect) -> Path {
        let rect = rect.insetBy(dx: self.inset, dy: self.inset)

        return Path { path in
            /// Horizontal Lines
            if horizontalDots > 1 && verticalDots > 1 {
                let unitDistanceBetweenHorizontalLines = 1.0 / CGFloat(horizontalDots - 1)
                let unitDistanceBetweenVerticalLines = 1.0 / CGFloat(verticalDots - 1)
                (0..<horizontalDots).forEach { x in
                    let unitX = unitDistanceBetweenVerticalLines * CGFloat(x)
                    (0..<verticalDots).forEach { y in
                        let unitY = unitDistanceBetweenHorizontalLines * CGFloat(y)
                        let point = CGPoint(unitPoint: UnitPoint(x: unitX, y: unitY), in: rect)
                        path.addArc(
                            center: point,
                            radius: radius,
                            startAngle: Angle(degrees: 0),
                            endAngle: Angle(degrees: 360),
                            clockwise: true
                        )
                    }
                }
            }
        }
        .offsetBy(dx: inset, dy: inset)
    }

    private init(inset: CGFloat, horizontalDots: Int, verticalDots: Int, radius: CGFloat = 1) {
        self.inset = inset
        self.horizontalDots = horizontalDots
        self.verticalDots = verticalDots
        self.radius = radius
    }

    public init(horizontalDots: Int = 0, verticalDots: Int = 0, radius: CGFloat = 1) {
        self.inset = 0
        self.horizontalDots = horizontalDots
        self.verticalDots = verticalDots
        self.radius = radius
    }
}
