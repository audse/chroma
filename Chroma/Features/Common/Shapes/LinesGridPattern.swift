//
//  LinesGridPattern.swift
//  Chroma
//
//  Created by Audrey Serene on 9/25/23.
//

import SwiftUI

public struct LinesGridPattern: InsettableShape {
    private let inset: CGFloat
    private let horizontalSpacing: CGFloat
    private let verticalSpacing: CGFloat

    public func inset(by amount: CGFloat) -> LinesGridPattern {
        LinesGridPattern(
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
                path.addLine(
                    from: CGPoint(x: x, y: rect.origin.y),
                    to: CGPoint(x: x, y: rect.end.y)
                )
                x += horizontalSpacing
            }
            var y = rect.origin.y
            while y < rect.end.y {
                path.addLine(
                    from: CGPoint(x: rect.origin.x, y: y),
                    to: CGPoint(x: rect.end.x, y: y)
                )
                y += horizontalSpacing
            }
        }
        .offsetBy(dx: inset, dy: inset)
    }

    private init(inset: CGFloat, horizontalSpacing: CGFloat, verticalSpacing: CGFloat) {
        self.inset = inset
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
    }

    public init(horizontalSpacing: CGFloat = 0, verticalSpacing: CGFloat = 0) {
        self.inset = 0
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
    }
}
