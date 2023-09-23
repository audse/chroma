//
//  LayerListItem.swift
//  Chroma
//
//  Created by Audrey Serene on 9/23/23.
//

import SwiftUI

struct LayerListItem: View {
    @EnvironmentObject var file: FileModel
    @EnvironmentObject var history: History
    
    @ObservedObject var layer: LayerModel
    
    var body: some View {
        Button {
            history.add(SelectLayerAction(layer))
        } label: {
            HStack {
                Text("\(file.artboard.layers.firstIndex(of: layer) ?? 0)").opacity(0.5)
                Spacer()
                EditableText(text: $layer.name)
                    .fixedSize()
                    .expandWidth()
                Spacer()
                LayerLockButton(layer: layer)
                LayerVisibiltyButton(layer: layer)
            }.background(Color.almostClear)
        }.composableButtonStyle(
            Btn.defaultPadding
            |> Btn.hStack
            |> Btn.filledAccent
            |> Btn.rounded
            |> Btn.scaled
        )
            .tinted(layer.id == history.getCurrentLayer()?.id ? Color.accentColor : Color.clear)
    }
}

#Preview {
    LayerListItem(layer: LayerModel())
        .environmentObject(FileModel(artboard: ArtboardModel()))
        .environmentObject(History())
}
