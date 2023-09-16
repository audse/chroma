//
//  HistoryList.swift
//  Chroma
//
//  Created by Audrey Serene on 9/14/23.
//

import SwiftUI

struct HistoryActionListItem: View {
    @EnvironmentObject var history: History
    @EnvironmentObject var canvasPixels: CanvasPixels
    
    @State var action: Action
    @State var isUndone = false
    
    var body: some View {
        Button {
            switch isUndone {
                case false: history.undoUntil(action, canvasPixels: canvasPixels)
                case true: history.redoUntil(action, canvasPixels: canvasPixels)
            }
        } label: {
            Label(getText(), systemImage: getIcon())
        }.foregroundColor(isUndone ? .secondary : .primary)
            .labelStyle(TrailingIconLabelStyle())
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
    @EnvironmentObject var canvasPixels: CanvasPixels
    
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
    }
}

struct HistoryList_Previews: PreviewProvider {
    static var drawSettings = DrawSettings()
    static var canvasPixels = CanvasPixels()
    static var previews: some View {
        HistoryList()
            .environmentObject(History()
                .history([
                    DrawAction(drawSettings.createPixel()),
                    EraseAction(drawSettings.createPixel(), 1),
                    DrawAction(drawSettings.createPixel()),
                ])
                .undoHistory([
                    DrawAction(drawSettings.createPixel()),
                    EraseAction(drawSettings.createPixel(), 2),
                ]))
            .environmentObject(canvasPixels)
    }
}
