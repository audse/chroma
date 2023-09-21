//
//  PixelCursor.swift
//  Chroma
//
//  Created by Audrey Serene on 9/12/23.
//

import SwiftUI

struct PixelCursor: View {
    @EnvironmentObject var drawSettings: DrawSettings
    
    var body: some View {
        let size: CGFloat = drawSettings.getPixelSize()
        switch drawSettings.tool {
        case .draw:
            PixelModel(
                shape: drawSettings.shape,
                color: drawSettings.color,
                size: size,
                rotation: drawSettings.rotation
            ).getView()
                .opacity(0.25)
                .animation(.easeInOut(duration: 0.2), value: drawSettings.rotation)
                .animation(.easeInOut(duration: 0.2), value: drawSettings.pixelSize)
                .frame(width: size, height: size)
                .allowsHitTesting(false)
        case .erase:
            Square()
                .size(width: size - 2, height: size - 2)
                .stroke(.white, style: StrokeStyle(
                    lineWidth: 3,
                    lineCap: .round,
                    lineJoin: .round
                ))
                .overlay(
                    PixelModel(
                        shape: SquareShape,
                        color: Color.clear,
                        size: drawSettings.getPixelSize() - 2
                    ).getShape()
                    .stroke(.black, style: StrokeStyle(
                        lineWidth: 2,
                        lineCap: .round,
                        lineJoin: .round,
                        dash: [2, 4]
                    ))
            )
                .position(x: size / 2 + 1, y: size / 2 + 1)
                .frame(width: size, height: size)
                .allowsHitTesting(false)
        case .fill:
            Circle()
                .size(width: size - 2, height: size - 2)
                .fill(drawSettings.color)
                .position(x: size / 2 + 1, y: size / 2 + 1)
                .frame(width: size, height: size)
                .allowsHitTesting(false)
                .opacity(0.5)
        }
    }
}

struct PixelCursor_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 12) {
            PixelCursor().environmentObject(DrawSettings())
            PixelCursor().environmentObject(DrawSettings().tool(.erase))
            PixelCursor().environmentObject(DrawSettings().tool(.fill))
        }
    }
}
