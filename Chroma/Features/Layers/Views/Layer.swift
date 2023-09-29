//
//  LayerView.swift
//  Chroma
//
//  Created by Audrey Serene on 9/23/23.
//

import SwiftUI

struct Layer: View {
    @ObservedObject var layer: LayerModel
    
    var body: some View {
        Canvas { context, _ in
            layer.filters.forEach { filter in
                switch filter {
                case .blur(let filter):
                    context.addFilter(.blur(radius: filter.radius))
                case .shadow(let filter):
                    context.addFilter(.shadow(
                        color: filter.color,
                        radius: filter.radius,
                        x: filter.offset.x,
                        y: filter.offset.y
                    ))
                }
            }
            layer.draw(&context)
        }.expand()
            .blendMode(layer.blendMode)
            .opacity(layer.opacity)
    }
}

#Preview {
    Layer(
        layer: LayerModel()
    )
}
