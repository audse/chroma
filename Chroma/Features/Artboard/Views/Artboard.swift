//
//  CanvasBase.swift
//  Chroma
//
//  Created by Audrey Serene on 9/15/23.
//

import SwiftUI

struct Artboard: View {
    @EnvironmentObject var currentArtboard: CurrentArtboardViewModel
    
    var body: some View {
        Canvas() { context, size in
            context.fill(
                Rectangle().path(in: CGRect(origin: CGPoint(0), size: size)),
                with: .color(currentArtboard.backgroundColor)
            )
            for layer in currentArtboard.layers {
                if layer.isVisible {
                    for pixel in layer.pixels {
                        pixel.draw(context)
                    }
                }
            }
        }
        .frame(
            width: currentArtboard.size.width,
            height: currentArtboard.size.height
        )
        .fixedSize()
    }
}

struct Artboard_Previews: PreviewProvider {
    private static var currentArtboard = CurrentArtboardViewModel().withNewLayer([
        Pixel(shape: SquareShape),
        Pixel(shape: CircleShape, position: CGPoint(250)),
        Pixel(shape: SquareShape, color: Color.blue, position: CGPoint(100))
    ])
    static var previews: some View {
        Artboard()
            .environmentObject(currentArtboard)
    }
}
