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
            Label(getText(), systemImage: getIcon())
        }.foregroundColor(isUndone ? .secondary : .primary)
            .labelStyle(SpacedTrailingIconLabelStyle())
            .help(getHelpText())
    }
    
    func getHelpText() -> String {
        switch isUndone {
            case false: return "Undo \(getText())"
            case true: return "Redo \(getText())"
        }
    }
    
    func getText() -> String {
        switch action {
            case is DrawAction: return "Draw"
            case is EraseAction: return "Erase"
            case is FillAction: return "Fill"
            case is LineAction: return "Line"
            default: return "Action"
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
                HistoryActionListItem(action: action, isUndone: true)
            }
            ForEach(history.history.reversed(), id: \.id) { action in
                HistoryActionListItem(action: action, isUndone: false)
            }
        }
        .buttonStyle(.plain)
        .frame(width: 70)
    }
}

struct HistoryList_Previews: PreviewProvider {
    static var drawSettings = DrawSettings()
    static var currentArtboard = ArtboardModel().withNewLayer()
    static var previews: some View {
        HistoryList()
            .environmentObject(History()
                .history([
                    DrawAction(drawSettings.createPixel(), currentArtboard.currentLayer!),
                    EraseAction(drawSettings.createPixel(), 1, currentArtboard.currentLayer!),
                    LineAction([drawSettings.createPixel()], currentArtboard.currentLayer!),
                    DrawAction(drawSettings.createPixel(), currentArtboard.currentLayer!),
                ])
                .undoHistory([
                    DrawAction(drawSettings.createPixel(), currentArtboard.currentLayer!),
                    EraseAction(drawSettings.createPixel(), 2, currentArtboard.currentLayer!),
                    FillAction([drawSettings.createPixel()], originalColor: .red, newColor: .black),
                ]))
            .environmentObject(currentArtboard)
    }
}
