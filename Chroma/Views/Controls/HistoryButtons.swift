//
//  HistoryButtons.swift
//  Chroma
//
//  Created by Audrey Serene on 9/14/23.
//

import SwiftUI

struct HistoryButtons: View {
    @EnvironmentObject var history: History
    @EnvironmentObject var currentCanvas: CurrentCanvas
    
    var body: some View {
        HStack {
            Button {
                history.undo()
            } label: {
                Image(systemName: "arrow.uturn.backward")
            }
            .disabled(history.history.isEmpty)
            .help("Undo")
            Button {
                history.redo()
            } label: {
                Image(systemName: "arrow.uturn.forward")
            }
            .disabled(history.undoHistory.isEmpty)
            .help("Redo")
        }.labelStyle(.iconOnly).active(false)
    }
}

struct HistoryButtons_Previews: PreviewProvider {
    static var previews: some View {
        HistoryButtons()
            .environmentObject(CurrentCanvas())
            .environmentObject(History())
    }
}
