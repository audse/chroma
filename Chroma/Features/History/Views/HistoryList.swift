//
//  HistoryList.swift
//  Chroma
//
//  Created by Audrey Serene on 9/14/23.
//

import SwiftUI

struct HistoryActionListItem: View {
    @EnvironmentObject var history: History

    @State var action: Action
    @State var isUndone = false

    var body: some View {
        Button {
            switch isUndone {
            case false: history.undoUntil(action)
            case true: history.redoUntil(action)
            }
        } label: {
            Label(action.getText(), systemImage: getIcon())
                .expandWidth()
                .background(Color.almostClear)
        }.foregroundColor(isUndone ? .secondary : .primary)
            .labelStyle(SpacedTrailingIconLabelStyle())
            .help(getHelpText())
    }

    func getHelpText() -> String {
        switch isUndone {
        case false: return "Undo \(action.getText())"
        case true: return "Redo \(action.getText())"
        }
    }

    func getIcon() -> String {
        switch isUndone {
        case true: return "arrow.uturn.forward"
        case false: return "arrow.uturn.backward"
        }
    }
}

struct HistoryList: View {
    @EnvironmentObject var history: History

    var body: some View {
        ScrollView {
            ForEach(history.undoHistory, id: \.id) { action in
                if !action.isSilent() {
                    HistoryActionListItem(action: action, isUndone: true)
                }
            }
            ForEach(history.history.reversed(), id: \.id) { action in
                if !action.isSilent() {
                    HistoryActionListItem(action: action, isUndone: false)
                }
            }
        }
        .buttonStyle(.plain)
        .frame(width: 100)
    }
}

struct HistoryList_Previews: PreviewProvider {
    static var drawSettings = DrawSettings()
    static var currentArtboard = ArtboardModel().withNewLayer()
    static var history = History()
    static var previews: some View {
        HistoryList()
            .environmentObject(history
                .history([
                    DrawAction(drawSettings.createPixel().positive(), history.getCurrentLayer()!),
                    EraseAction(drawSettings.createPixel().positive(), history.getCurrentLayer()!),
                    NewLayerAction(currentArtboard, index: nil),
                    LineAction([drawSettings.createPixel().positive()], history.getCurrentLayer()!),
                    DrawAction(drawSettings.createPixel().positive(), history.getCurrentLayer()!)
                ])
                .undoHistory([
                    DrawAction(drawSettings.createPixel().positive(), history.getCurrentLayer()!),
                    EraseAction(drawSettings.createPixel().positive(), history.getCurrentLayer()!),
                    DeleteLayerAction(currentArtboard.newLayer(), currentArtboard),
                    FillAction([drawSettings.createPixel().positive()], originalColor: .red, newColor: .black)
                ]))
            .environmentObject(currentArtboard)
    }
}
