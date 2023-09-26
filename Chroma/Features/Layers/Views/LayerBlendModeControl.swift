//
//  LayerBlendModeControl.swift
//  Chroma
//
//  Created by Audrey Serene on 9/26/23.
//

import SwiftUI

extension BlendMode {
    var name: String {
        switch self {
        case .normal: "Normal"
        case .screen: "Screen"
        case .multiply: "Multiply"
        default: ""
        }
    }
}

struct LayerBlendModeControl: View {
    @EnvironmentObject var history: History
    @ObservedObject var layer: LayerModel
    
    init(_ layer: LayerModel) {
        self.layer = layer
    }
    
    var body: some View {
        MenuButton(label: Text(layer.blendMode.name)) {
            Button(BlendMode.normal.name) {
                history.addOrAccumulate(ChangeLayerBlendModeAction(layer, .normal))
            }
            Button(BlendMode.screen.name) {
                history.addOrAccumulate(ChangeLayerBlendModeAction(layer, .screen))
            }
            Button(BlendMode.multiply.name) {
                history.addOrAccumulate(ChangeLayerBlendModeAction(layer, .multiply))
            }
        }.frame(maxWidth: 100)
    }
}

#Preview {
    LayerBlendModeControl(LayerModel())
}
