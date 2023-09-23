//
//  LayerLockButton.swift
//  Chroma
//
//  Created by Audrey Serene on 9/23/23.
//

import SwiftUI

struct LayerLockButton: View {
    @EnvironmentObject var history: History
    @ObservedObject var layer: LayerModel
    
    var body: some View {
        Button {
            history.add(ToggleLayerLockAction(layer))
        } label: {
            Image(systemName: layer.isLocked ? "lock.fill" : "lock.open.fill")
        }.buttonStyle(.plain)
            .frame(width: 18)
    }
}

#Preview {
    VStack(alignment: .leading) {
        LayerLockButton(layer: LayerModel())
            .environmentObject(History())
        LayerLockButton(layer: LayerModel(isLocked: true))
            .environmentObject(History())
    }
}
