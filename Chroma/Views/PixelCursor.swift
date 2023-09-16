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
        ZStack {
            Pixel(
                shape: drawSettings.tool == .draw
                    ? drawSettings.shape
                    : SquareShape,
                color: drawSettings.tool == .draw
                    ? drawSettings.color
                    : .clear,
                size: drawSettings.getPixelSize(),
                rotation: drawSettings.tool == .draw
                    ? drawSettings.rotation
                    : Angle()
            ).getView()
                .opacity(0.25)
                .animation(.easeInOut(duration: 0.2), value: drawSettings.rotation)
                .animation(.easeInOut(duration: 0.2), value: drawSettings.pixelSize)
            Pixel(
                shape: SquareShape,
                color: Color.clear,
                size: drawSettings.getPixelSize() - 2
            ).getShape()
                .stroke(.black, style: StrokeStyle(
                    lineWidth: drawSettings.tool == .erase ? 1 : 0,
                    lineCap: .round,
                    dash: [2, 4]
                ))
                .position(
                    x: drawSettings.getPixelSize() / 2 + 1,
                    y: drawSettings.getPixelSize() / 2 + 1
                )
        }.frame(
            width: drawSettings.getPixelSize(),
            height: drawSettings.getPixelSize()
        )
    }
}

struct PixelCursor_Previews: PreviewProvider {
    static var previews: some View {
        PixelCursor().environmentObject(DrawSettings())
    }
}
