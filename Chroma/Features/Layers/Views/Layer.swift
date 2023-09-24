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
            layer.draw(&context)
        }.expand()
    }
}

#Preview {
    Layer(
        layer: LayerModel()
    )
}
