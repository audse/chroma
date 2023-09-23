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
            history.add(NewLayerAction(file.artboard))
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
