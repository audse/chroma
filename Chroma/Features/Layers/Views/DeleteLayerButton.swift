//
//  DeleteLayerButton.swift
//  Chroma
//
//  Created by Audrey Serene on 9/23/23.
//

import SwiftUI

struct DeleteLayerButton: View {
    @EnvironmentObject var file: FileModel
    @EnvironmentObject var history: History
    
    var body: some View {
        Button(
            role: .destructive,
            action: {
                if let layer = history.getCurrentLayer() {
                    history.add(DeleteLayerAction(layer, file.artboard))
                }
            },
            label: {
                Image(systemName: "minus")
                    .scaledToFit()
                    .background(Color.almostClear)
                    .padding(2)
            }
        )
        .fixedSize()
        .buttonStyle(.plain)
        .disabled(history.getCurrentLayer() == nil)
    }
}

#Preview {
    DeleteLayerButton()
        .environmentObject(History())
        .environmentObject(FileModel(artboard: ArtboardModel()))
}
