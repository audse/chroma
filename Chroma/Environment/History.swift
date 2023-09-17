//
//  History.swift
//  Chroma
//
//  Created by Audrey Serene on 9/14/23.
//

import SwiftUI

class Action: Identifiable {
    var id = UUID()
    func undo() {}
    func redo() {}
}

class DrawAction: Action {
    var pixel: Pixel
    var index: Int = -1
    var layer: Layer
    
    init(_ pixelValue: Pixel, _ layerValue: Layer) {
        pixel = pixelValue
        layer = layerValue
    }
    
    override func undo() {
        index = layer.findPixel(pixel)
        if index != -1 {
            _ = layer.removePixel(index)
        }
    }
    
    override func redo() {
        if index != -1 {
            layer.insertPixel(pixel, at: index)
        }
    }
}

class EraseAction: Action {
    var pixel: Pixel
    var index: Int
    var layer: Layer
    
    init(_ pixelValue: Pixel, _ indexValue: Int, _ layerValue: Layer) {
        pixel = pixelValue
        index = indexValue
        layer = layerValue
    }
    
    override func undo() {
        if index != -1 {
            layer.insertPixel(pixel, at: index)
        }
    }
    
    override func redo() {
        _ = layer.removePixel(index)
    }
}

class History: ObservableObject {
    @Published var history: [Action] = []
    @Published var undoHistory: [Action] = []
    
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
