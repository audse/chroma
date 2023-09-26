//
//  NewLayerButton.swift
//  Chroma
//
//  Created by Audrey Serene on 9/23/23.
//

import SwiftUI

struct NewLayerButton: View {
    @EnvironmentObject var file: FileModel
    @EnvironmentObject var history: History
    
    var body: some View {
        Button {
            var index: Int?
            if let currentLayer = history.getCurrentLayer() {
                index = file.artboard.layers.firstIndex(of: currentLayer)
            }
            if let indexValue = index {
                index = indexValue + 1
            }
            history.add(NewLayerAction(file.artboard, index: index))
        } label: {
            Image(systemName: "plus")
                .padding(2)
        }.active(false)
            .composableButtonStyle(
                Btn.filledAccent
                |> Btn.rounded
            )
            .tinted(.secondary)
    }
}

#Preview {
    NewLayerButton()
        .environmentObject(FileModel(artboard: ArtboardModel()))
        .environmentObject(History())
}
