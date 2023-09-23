//
//  LayerList.swift
//  Chroma
//
//  Created by Audrey Serene on 9/16/23.
//

import SwiftUI

struct LayerList: View {
    @EnvironmentObject var file: FileModel
    @EnvironmentObject var history: History
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 6) {
                Text("Layers")
                    .font(.label)
                    .foregroundColor(.secondary.lerp(.primary))
                Spacer()
                DeleteLayerButton()
                    .frame(width: 18, height: 18)
                    .buttonStyle(.plain)
                NewLayerButton()
                    .frame(width: 18, height: 18)
            }.padding(.bottom, 4)
            ScrollView(.vertical) {
                ForEach(file.artboard.layers.reversed(), id: \.id) { layer in
                    LayerListItem(layer: layer)
                }
            }.well()
        }
    }
}

#Preview {
    LayerList()
        .environmentObject(History())
        .environmentObject(FileModel(artboard: ArtboardModel()
            .withNewLayer()
            .withNewLayer()
            .withNewLayer()))
}
