//
//  LayerList.swift
//  Chroma
//
//  Created by Audrey Serene on 9/16/23.
//

import SwiftUI

struct LayerListItem: View {
    @EnvironmentObject var currentArtboard: ArtboardViewModel
    @State var layer: Layer
    var body: some View {
        Button {
            currentArtboard.setLayer(layer)
        } label: {
            HStack {
                Text("\(currentArtboard.getIndex(layer) ?? 0)").opacity(0.5)
                Spacer()
                Text(layer.model.name)
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
            .tinted(layer.id == currentArtboard.layer?.id ? Color.accentColor : Color.clear)
    }
}

struct LayerList: View {
    @EnvironmentObject var currentArtboard: ArtboardViewModel
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Layers")
                Spacer()
                if let layer = currentArtboard.layer {
                    Button(
                        role: .destructive,
                        action: {
                            currentArtboard.deleteLayer(layer)
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
                }
                Button {
                    currentArtboard.setLayer(currentArtboard.newLayer())
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
            .environmentObject(ArtboardViewModel().withNewLayer().withNewLayer().withNewLayer())
    }
}
