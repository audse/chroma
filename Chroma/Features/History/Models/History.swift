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
// swiftlint:enable identifier_name

class History: ObservableObject {
    @Published var history: [Action] = []
    @Published var undoHistory: [Action] = []

    init() {
        _ = RequestUndoEvent.subscribe { _ in self.undo() }
        _ = RequestRedoEvent.subscribe { _ in self.redo() }
        _ = RequestSelectAll.subscribe {
            if let layer = self.getCurrentLayer() {
                self.add(SelectAction(layer.pixels, layer))
            }
        }
        _ = RequestDeselectAll.subscribe {
            if let layer = self.getCurrentLayer() {
                self.add(DeselectAllAction(layer))
            }
        }
    }

    func history(_ value: [Action]) -> History {
        history.append(contentsOf: value)
        return self
    }

    func undoHistory(_ value: [Action]) -> History {
        undoHistory.append(contentsOf: value)
        return self
    }

    func add(_ action: Action) {
        history.append(action)
        action.perform()
        undoHistory.removeAll()
    }
    
    func addOrAccumulate(_ action: AccumulatableAction) {
        if let last = history.last,
           let last = last as? AccumulatableAction,
           type(of: action) == type(of: last),
           case .success = last.accumulate(with: action) {
            last.perform()
        } else {
            history.append(action)
        }
        undoHistory.removeAll()
    }

    func undoUntil(_ action: Action) {
        while let currentAction = history.popLast() {
            currentAction.undo()
            undoHistory.append(currentAction)
            if currentAction.id == action.id {
                break
            }
        }
    }

    func redoUntil(_ action: Action) {
        while let currentAction = undoHistory.popLast() {
            currentAction.redo()
            history.append(currentAction)
            if currentAction.id == action.id {
                break
            }
        }
    }

    func undo() {
        if let action = history.popLast() {
            action.undo()
            undoHistory.append(action)
        }
    }

    func redo() {
        if let action = undoHistory.popLast() {
            action.redo()
            history.append(action)
        }
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
