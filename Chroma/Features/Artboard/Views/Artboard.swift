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
        ZStack {
            Canvas { context, size in
                context.fill(
                    Rectangle().path(in: CGRect(origin: CGPoint(0), size: size)),
                    with: .color(artboard.backgroundColor)
                )
            }
            ForEach(artboard.layers, id: \.id) { layer in
                Layer(layer: layer)
            }
        }
        .frame(
            width: artboard.size.width,
            height: artboard.size.height
        )
        .fixedSize()
    }
}

#Preview {
    Artboard(artboard: PreviewArtboardModelBuilder().build())
}
