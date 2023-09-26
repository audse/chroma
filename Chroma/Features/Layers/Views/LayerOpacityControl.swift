//
//  LayerOpacityControl.swift
//  Chroma
//
//  Created by Audrey Serene on 9/26/23.
//

import SwiftUI

struct LayerOpacityControl: View {
    @EnvironmentObject var history: History
    
    @ObservedObject var layer: LayerModel
    @State var opacity: Double
    
    init(_ layer: LayerModel) {
        self.layer = layer
        self.opacity = layer.opacity
    }
    
    var body: some View {
        NumberTextField(
            value: $opacity,
            min: 0.0,
            step: 0.01,
            formatter: getFormatter()
        ).frame(maxWidth: 55)
            .onChange(of: opacity) { newValue in
                history.addOrAccumulate(ChangeLayerOpacityAction(layer, newValue))
            }
    }
    
    func getFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.allowsFloats = true
        formatter.maximumFractionDigits = 2
        return formatter
    }
}

#Preview {
    LayerOpacityControl(LayerModel())
        .environmentObject(History())
}
