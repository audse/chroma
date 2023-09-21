//
//  LineToolIcon.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

struct LineToolIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(
            center: rect.origin + CGPoint(3),
            radius: 2,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 360),
            clockwise: true
        )
        path.addArc(
            center: rect.end - CGPoint(3),
            radius: 2,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 360),
            clockwise: true
        )
        path.move(to: rect.origin + CGPoint(6))
        path.addLine(to: rect.end - CGPoint(6))
        return path
    }
    
    static func getView() -> some View {
        LineToolIcon()
            .stroke(.white, style: StrokeStyle(
                lineWidth: 1,
                lineCap: .round
            ))
            .frame(width: 14, height: 14)
            .blur(radius: 0.2)
    }
}
