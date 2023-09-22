//
//  DrawSelection.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

struct DrawSelection: View {
    var tool: Tool
    var points: [CGPoint]
    
    var body: some View {
        Canvas { context, _ in
            let shape = getShape()
            context.stroke(shape, with: .color(.white), style: StrokeStyle(
                lineWidth: 2.5,
                lineCap: .round,
                dash: [6]
            ))
            context.stroke(shape, with: .color(.black), style: StrokeStyle(
                lineWidth: 1.25,
                lineCap: .round,
                dash: [6]
            ))
        }.allowsHitTesting(false)
    }
    
    public func getShape() -> Path {
        switch tool {
        case .rectSelect:
            var shape = Path()
            let first = points.first ?? CGPoint(), last = points.last ?? CGPoint()
            shape.addRect(CGRect(start: first, end: last))
            return shape
        case .lassoSelect:
            var shape = Path()
            shape.move(to: points.first ?? CGPoint())
            points.forEach { point in shape.addLine(to: point) }
            return shape
        default:
            return Path()
        }
    }
}

struct DrawSelection_Previews: PreviewProvider {
    static var previews: some View {
        DrawSelection(tool: .rectSelect, points: [CGPoint(0), CGPoint(400)])
    }
}
