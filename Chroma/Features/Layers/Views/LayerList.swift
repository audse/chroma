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
    
    let layerListItemHeight: CGFloat = 36
    
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
                VStack(spacing: 0) {
                    ForEach(file.artboard.layers.reversed(), id: \.id) { layer in
                        LayerListItem(layer: layer)
                            .draggable(layer.id.uuidString)
                            .frame(height: layerListItemHeight)
                    }
                }
            }
            .well()
            .dropDestination(for: String.self) { layers, point in
                guard let layerId = layers.first else { return false }
                guard let layer = getLayerById(layerId) else { return false }
                let newIndex = getLayerIndexAtDropPoint(point)
                history.add(MoveLayerAction(layer, file.artboard, to: newIndex))
                return true
            }
        }
    }
    
    func getLayerById(_ layerId: String) -> LayerModel? {
        return file.artboard.layers.first { layer in layer.id.uuidString == layerId }
    }
    
    func getLayerIndexAtDropPoint(_ point: CGPoint) -> Int {
        return file.artboard.layers.count - Int(floor(point.y / layerListItemHeight))
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
