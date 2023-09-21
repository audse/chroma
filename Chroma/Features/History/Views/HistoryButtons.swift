//
//  HistoryButtons.swift
//  Chroma
//
//  Created by Audrey Serene on 9/14/23.
//

import SwiftUI

struct HistoryButtons: View {
    @EnvironmentObject var history: History

    var body: some View {
        HStack {
            Button {
                history.undo()
            } label: {
                Image(systemName: "arrow.uturn.backward")
            }
            .disabled(history.history.isEmpty)
            .help("Undo")
            .keyboardShortcut("z", modifiers: [.command])
            Button {
                history.redo()
            } label: {
                Image(systemName: "arrow.uturn.forward")
            }
            .disabled(history.undoHistory.isEmpty)
            .help("Redo")
            .keyboardShortcut("z", modifiers: [.command, .shift])
        }.labelStyle(.iconOnly).active(false)
    }
}

struct HistoryButtons_Previews: PreviewProvider {
    static var previews: some View {
        HistoryButtons()
            .environmentObject(ArtboardModel())
            .environmentObject(History())
    }
}
