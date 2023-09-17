//
//  LayerList.swift
//  Chroma
//
//  Created by Audrey Serene on 9/16/23.
//

import SwiftUI

struct LayerListItem: View {
    @EnvironmentObject var currentCanvas: CurrentCanvas
    @State var layer: Layer
    var body: some View {
        Button {
            currentCanvas.currentLayer = layer
        } label: {
            HStack {
                Text("\(currentCanvas.getIndex(layer) ?? 0)").opacity(0.5)
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
            |> Btn.tinted
            |> Btn.rounded
            |> Btn.scaled
        )
            .tint(layer.id == currentCanvas.currentLayer?.id ? Color.accentColor : Color.clear)
    }
}

struct LayerList: View {
    @EnvironmentObject var currentCanvas: CurrentCanvas
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Layers")
                Spacer()
                if let layer = currentCanvas.currentLayer {
                    Button(
                        role: .destructive,
                        action: {
                            currentCanvas.deleteLayer(layer)
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
                    currentCanvas.currentLayer = currentCanvas.newLayer()
                } label: {
                    Image(systemName: "plus")
                }
            }.padding(.bottom, 4)
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(currentCanvas.layers.reversed(), id: \.id) { layer in
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
            .environmentObject(CurrentCanvas().withNewLayer().withNewLayer().withNewLayer())
    }
}
