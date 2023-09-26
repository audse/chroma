//
//  DotsGridPattern.swift
//  Chroma
//
//  Created by Audrey Serene on 9/20/23.
//

import SwiftUI

public struct DotsGridPattern: InsettableShape {
    private let inset: CGFloat
    private let horizontalSpacing: CGFloat
    private let verticalSpacing: CGFloat
    private let radius: CGFloat

    public func inset(by amount: CGFloat) -> DotsGridPattern {
        DotsGridPattern(
            inset: self.inset + amount,
            horizontalSpacing: self.horizontalSpacing,
            verticalSpacing: self.verticalSpacing
        )
    }

    public func path(in rect: CGRect) -> Path {
        let rect = rect.insetBy(dx: self.inset, dy: self.inset)

        return Path { path in
            var x = rect.origin.x
            while x < rect.end.x {
                var y = rect.origin.y
                while y < rect.end.y {
                    path.addArc(
                        center: CGPoint(x: x, y: y),
                        radius: radius,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 360),
                        clockwise: true
                    )
                    y += verticalSpacing
                }
                x += horizontalSpacing
            }
        }
        .offsetBy(dx: inset, dy: inset)
    }

    private init(inset: CGFloat, horizontalSpacing: CGFloat, verticalSpacing: CGFloat, radius: CGFloat = 1) {
        self.inset = inset
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.radius = radius
    }

    public init(horizontalSpacing: CGFloat = 0, verticalSpacing: CGFloat = 0, radius: CGFloat = 1) {
        self.inset = 0
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.radius = radius
    }
}
