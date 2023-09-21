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
        var path = Path()
        path.move(to: rect.end)
        path.addArc(
            center: rect.end,
            radius: sideLength,
            startAngle: Angle(degrees: 270),
            endAngle: Angle(degrees: 180),
            clockwise: true
        )
        path.addLine(to: rect.end)
        path.addLine(to: rect.bottomLeft)
        path.closeSubpath()
        return path
    }
}
