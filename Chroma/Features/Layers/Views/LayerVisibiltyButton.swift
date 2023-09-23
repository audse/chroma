//
//  LayerVisibiltyButton.swift
//  Chroma
//
//  Created by Audrey Serene on 9/23/23.
//

import SwiftUI

struct LayerVisibiltyButton: View {
    @EnvironmentObject var history: History
    @ObservedObject var layer: LayerModel
    
    var body: some View {
        Button {
            history.add(ToggleLayerVisibilityAction(layer))
        } label: {
            Image(systemName: layer.isVisible ? "eye.fill" : "eye.slash.fill")
        }.buttonStyle(.plain)
    }
}

#Preview {
    LayerVisibiltyButton(
        layer: LayerModel()
    )
}
