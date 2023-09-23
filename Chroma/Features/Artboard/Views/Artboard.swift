//
//  CanvasBase.swift
//  Chroma
//
//  Created by Audrey Serene on 9/15/23.
//

import SwiftUI

struct Artboard: View {
    @ObservedObject var artboard: ArtboardModel

    var body: some View {
        Canvas { context, size in
            context.fill(
                Rectangle().path(in: CGRect(origin: CGPoint(0), size: size)),
                with: .color(artboard.backgroundColor)
            )
            artboard.layers.forEach { layer in layer.draw(&context) }
        }
        .frame(
            width: artboard.size.width,
            height: artboard.size.height
        )
        .fixedSize()
    }
}

struct Artboard_Previews: PreviewProvider {
    static var previews: some View {
        Artboard(artboard: PreviewArtboardModelBuilder().build())
    }
}
