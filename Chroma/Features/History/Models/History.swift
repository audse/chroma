//
//  History.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

// swiftlint:disable identifier_name
let RequestUndoEvent = EmptyChromaEvent("Request Undo")
let RequestRedoEvent = EmptyChromaEvent("Request Redo")
let RequestSelectAll = EmptyChromaEvent("Select All")
let RequestDeselectAll = EmptyChromaEvent("Deselect All")
let RequestCopy = EmptyChromaEvent("Copy")
let RequestPaste = EmptyChromaEvent("Paste")
let RequestCut = EmptyChromaEvent("Cut")
// swiftlint:enable identifier_name

class History: ObservableObject {
    @Published var history: [Action] = []
    @Published var undoHistory: [Action] = []

    init(
        history: [Action] = [],
        undoHistory: [Action] = []
    ) {
        RequestUndoEvent.subscribe { self.undo() }
        RequestRedoEvent.subscribe { self.redo() }
        RequestSelectAll.subscribe {
            if let layer = self.getCurrentLayer() {
                self.add(SelectAction(layer.pixels, layer))
            }
        }
        RequestDeselectAll.subscribe {
            if let layer = self.getCurrentLayer() {
                self.add(DeselectAllAction(layer))
            }
        }
        RequestCut.subscribe {
            let pixels = self.getCurrentSelection()
            if let layer = self.getCurrentLayer() {
                self.add(CutAction(pixels, layer))
            }
        }
        RequestCopy.subscribe {
            let pixels = self.getCurrentSelection()
            self.add(CopyAction(pixels))
        }
        RequestPaste.subscribe {
            let pixels = self.getCopiedPixels()
            if let layer = self.getCurrentLayer() {
                self.add(PasteAction(pixels, layer))
            }
        }
        self.history = history
        self.undoHistory = undoHistory
    }
    
    var nonEditorHistory: [Action] {
        self.history.filter { !$0.isEditorAction() }
    }
    
    var nonEditorUndoHistory: [Action] {
        self.undoHistory.filter { !$0.isEditorAction() }
    }

    func add(_ action: Action) {
        history.append(action)
        action.perform()
        if !action.isEditorAction() {
            undoHistory.removeAll()
        }
    }
    
    func addOrAccumulate(_ action: AccumulatableAction) {
        if let last = nonEditorHistory.last,
           let last = last as? AccumulatableAction,
           type(of: action) == type(of: last),
           case .success = last.accumulate(with: action) {
            last.perform()
        } else {
            add(action)
        }
    }

    func undoUntil(_ action: Action) {
        for currentAction in history.reversed() {
            if currentAction.isEditorAction() {
                continue
            }
            undo(currentAction)
            if currentAction.id == action.id {
                break
            }
        }
    }

    func redoUntil(_ action: Action) {
        for currentAction in undoHistory.reversed() {
            if currentAction.isEditorAction() {
                continue
            }
            redo(currentAction)
            if currentAction.id == action.id {
                break
            }
        }
    }

    func undo() {
        for action in history.reversed() {
            if action.isEditorAction() {
                continue
            }
            return undo(action)
        }
    }
    
    func undo(_ action: Action) {
        action.undo()
        undoHistory.append(action)
        history.remove(action)
    }

    func redo() {
        for action in undoHistory.reversed() {
            if action.isEditorAction() {
                continue
            }
            return redo(action)
        }
    }
    
    func redo(_ action: Action) {
        action.redo()
        history.append(action)
        undoHistory.remove(action)
    }

    func clear() {
        history.removeAll()
        undoHistory.removeAll()
    }
}

private struct HistoryKey: EnvironmentKey {
    static var defaultValue = History()
}

extension EnvironmentValues {
    var history: History {
        get { self[HistoryKey.self] }
        set (newValue) { self[HistoryKey.self] = newValue }
    }
}
