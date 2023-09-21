//
//  RectToolIcon.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

struct RectToolIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(
            center: rect.origin + CGPoint(x: 1.5, y: 3),
            radius: 2,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 360),
            clockwise: true
        )
        path.addArc(
            center: rect.end - CGPoint(x: 1.5, y: 3),
            radius: 2,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 360),
            clockwise: true
        )
        path.addArc(
            center: rect.topRight + CGPoint(x: -1.5, y: 3),
            radius: 2,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 360),
            clockwise: true
        )
        path.addArc(
            center: rect.bottomLeft + CGPoint(x: 1.5, y: -3),
            radius: 2,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 360),
            clockwise: true
        )
        path.move(to: rect.origin + CGPoint(x: 6, y: 3))
        path.addLine(to: rect.origin + CGPoint(x: 8, y: 3))
        path.move(to: rect.origin + CGPoint(x: 6, y: 11))
        path.addLine(to: rect.origin + CGPoint(x: 8, y: 11))
        path.move(to: rect.origin + CGPoint(x: 1, y: 7))
        path.addLine(to: rect.origin + CGPoint(x: 1, y: 7))
        path.move(to: rect.origin + CGPoint(x: 13, y: 7))
        path.addLine(to: rect.origin + CGPoint(x: 13, y: 7))
        return path
    }
    
    static func getView() -> some View {
        RectToolIcon()
            .stroke(.white, style: StrokeStyle(
                lineWidth: 1,
                lineCap: .round
            ))
            .frame(width: 14, height: 14)
            .blur(radius: 0.2)
    }
}
