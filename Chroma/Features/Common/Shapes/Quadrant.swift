//
//  Quadrant.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct Quadrant: Shape, Identifiable {
    var id = UUID()
    func path(in rect: CGRect) -> Path {
        let sideLength = min(rect.width, rect.height)
        var p = Path()
        p.move(to: rect.end)
        p.addArc(
            center: rect.end,
            radius: sideLength,
            startAngle: Angle(degrees: 270),
            endAngle: Angle(degrees: 180),
            clockwise: true
        )
        p.addLine(to: rect.end)
        p.addLine(to: rect.bottomLeft)
        p.closeSubpath()
        return p
    }
}
