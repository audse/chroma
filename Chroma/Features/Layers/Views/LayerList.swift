//
//  LayerList.swift
//  Chroma
//
//  Created by Audrey Serene on 9/16/23.
//

import SwiftUI

struct LayerListItem: View {
    @EnvironmentObject var currentArtboard: ArtboardModel
    @State var layer: LayerModel
    var body: some View {
        Button {
            currentArtboard.currentLayer = layer
        } label: {
            HStack {
                Text("\(currentArtboard.getIndex(layer) ?? 0)").opacity(0.5)
                Spacer()
                Text(layer.name)
                Spacer()
                Button {
                    layer.toggle()
                } label: {
                    Image(systemName: layer.isVisible ? "eye.fill" : "eye.slash.fill")
                }.buttonStyle(.plain)
            }.background(Color.almostClear)
        }.composableButtonStyle(
            Btn.defaultPadding
            |> Btn.hStack
            |> Btn.filledAccent
            |> Btn.rounded
            |> Btn.scaled
        )
            .tinted(layer.id == currentArtboard.currentLayer?.id ? Color.accentColor : Color.clear)
    }
}

struct LayerList: View {
    @EnvironmentObject var currentArtboard: ArtboardModel
    @EnvironmentObject var history: History
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Layers")
                Spacer()
                Button(
                    role: .destructive,
                    action: {
                        if let layer = currentArtboard.currentLayer {
                            history.add(DeleteLayerAction(layer, currentArtboard))
                        }
                    },
                    label: {
                        Image(systemName: "minus")
                            .scaledToFit()
                            .frame(width: 24, height: 18)
                            .background(Color.almostClear)
                    }
                )
                .fixedSize()
                .buttonStyle(.plain)
                .disabled(currentArtboard.currentLayer == nil)
                Button {
                    history.add(NewLayerAction(currentArtboard))
                } label: {
                    Image(systemName: "plus")
                }
            }.padding(.bottom, 4)
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(currentArtboard.layers.reversed(), id: \.id) { layer in
                        LayerListItem(layer: layer)
                    }
                }
            }.well()
        }
    }
}

struct LayerList_Previews: PreviewProvider {
    static var previews: some View {
        LayerList()
            .environmentObject(ArtboardModel().withNewLayer().withNewLayer().withNewLayer())
    }
}
