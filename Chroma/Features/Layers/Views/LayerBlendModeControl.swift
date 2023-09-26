//
//  LayerBlendModeControl.swift
//  Chroma
//
//  Created by Audrey Serene on 9/26/23.
//

import SwiftUI

let supportedBlendModes: [BlendMode] = [
    .normal,
    .screen,
    .multiply,
    .overlay,
    .color,
    .colorBurn,
    .colorDodge,
    .darken,
    .difference,
    .lighten,
    .softLight,
    .hardLight,
    .exclusion,
    .hue,
    .saturation,
    .luminosity
]

extension BlendMode: Identifiable {
    public var id: String { name }
    var name: String {
        switch self {
        case .color: "Color"
        case .colorBurn: "Color Burn"
        case .colorDodge: "Color Dodge"
        case .darken: "Darken"
        case .difference: "Difference"
        case .normal: "Normal"
        case .multiply: "Multiply"
        case .screen: "Screen"
        case .overlay: "Overlay"
        case .lighten: "Lighten"
        case .softLight: "Soft Light"
        case .hardLight: "Hard Light"
        case .exclusion: "Exclusion"
        case .hue: "Hue"
        case .saturation: "Saturation"
        case .luminosity: "Luminosity"
        case .sourceAtop: "Source Atop"
        case .destinationOver: "Destination Over"
        case .destinationOut: "Destination Out"
        case .plusDarker: "Plus Darker"
        case .plusLighter: "Plus Lighter"
        @unknown default: "Blend"
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
            ForEach(supportedBlendModes, id: \.id) { blendMode in
                Button(blendMode.name) {
                    history.addOrAccumulate(ChangeLayerBlendModeAction(layer, blendMode))
                }
            }
        }.frame(maxWidth: 100)
    }
}

#Preview {
    LayerBlendModeControl(LayerModel())
}
