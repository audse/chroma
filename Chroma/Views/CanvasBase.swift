//
//  CanvasBase.swift
//  Chroma
//
//  Created by Audrey Serene on 9/15/23.
//

import SwiftUI

struct CanvasBase: View {
    @EnvironmentObject var canvasPixels: CanvasPixels
    @Environment(\.canvasSize) var canvasSize
    @Environment(\.canvasBgColor) var canvasBgColor
    
    var body: some View {
        Canvas() { context, size in
            context.fill(
                Rectangle().path(in: CGRect(origin: CGPoint(0), size: size)),
                with: .color(canvasBgColor)
            )
            for pixel in canvasPixels.pixels {
                pixel.draw(context)
            }
        }
        .frame(
            width: canvasSize.width,
            height: canvasSize.height
        )
        .fixedSize()
    }
}

struct CanvasBase_Previews: PreviewProvider {
    private static var canvasPixels = CanvasPixels().pixels([
        Pixel(shape: SquareShape),
        Pixel(shape: CircleShape, position: CGPoint(250)),
        Pixel(shape: SquareShape, color: Color.blue, position: CGPoint(100))
    ])
    
    static var previews: some View {
        CanvasBase()
            .environmentObject(canvasPixels)
    }
}
