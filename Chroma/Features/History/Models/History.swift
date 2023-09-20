//
//  History.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

let RequestUndoEvent = EmptyChromaEvent("Request Undo")
let RequestRedoEvent = EmptyChromaEvent("Request Redo")

class History: ObservableObject {
    @Published var history: [Action] = []
    @Published var undoHistory: [Action] = []
    
    init() {
        _ = RequestUndoEvent.subscribe { _ in self.undo() }
        _ = RequestRedoEvent.subscribe { _ in self.redo() }
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
