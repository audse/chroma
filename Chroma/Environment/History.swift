//
//  History.swift
//  Chroma
//
//  Created by Audrey Serene on 9/14/23.
//

import SwiftUI

class Action: Identifiable {
    var id = UUID()
    func undo(
        drawSettings: DrawSettings?,
        canvasPixels: CanvasPixels?
    ) {}
    func redo(
        drawSettings: DrawSettings?,
        canvasPixels: CanvasPixels?
    ) {}
}

class DrawAction: Action {
    var pixel: Pixel
    var index: Int = -1
    
    init(_ pixelValue: Pixel) {
        pixel = pixelValue
    }
    
    override func undo(
        drawSettings: DrawSettings?,
        canvasPixels: CanvasPixels?
    ) {
        if case Optional.some(let canvasPixels) = canvasPixels {
            index = canvasPixels.findPixel(pixel)
            if index != -1 {
                canvasPixels.pixels.remove(at: index)
            }
        }
    }
    
    override func redo(
        drawSettings: DrawSettings?,
        canvasPixels: CanvasPixels?
    ) {
        if case Optional.some(let canvasPixels) = canvasPixels {
            if index != -1 {
                canvasPixels.pixels.insert(pixel, at: index)
            }
        }
    }
}

class EraseAction: Action {
    var pixel: Pixel
    var index: Int = -1
    
    init(_ pixelValue: Pixel, _ indexValue: Int) {
        pixel = pixelValue
        index = indexValue
    }
    
    override func undo(
        drawSettings: DrawSettings?,
        canvasPixels: CanvasPixels?
    ) {
        if case Optional.some(let canvasPixels) = canvasPixels {
            if index != -1 {
                canvasPixels.pixels.insert(pixel, at: index)
            }
        }
    }
    
    override func redo(
        drawSettings: DrawSettings?,
        canvasPixels: CanvasPixels?
    ) {
        if case Optional.some(let canvasPixels) = canvasPixels {
            canvasPixels.pixels.remove(at: index)
        }
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
    
    func undoUntil(
        _ action: Action,
        drawSettings: DrawSettings? = nil,
        canvasPixels: CanvasPixels?
    ) {
        while case Optional.some(let currentAction) = history.popLast() {
            currentAction.undo(drawSettings: drawSettings, canvasPixels: canvasPixels)
            undoHistory.append(currentAction)
            if currentAction.id == action.id {
                break
            }
        }
    }
    
    func redoUntil(
        _ action: Action,
        drawSettings: DrawSettings? = nil,
        canvasPixels: CanvasPixels?
    ) {
        while case Optional.some(let currentAction) = undoHistory.popLast() {
            currentAction.redo(drawSettings: drawSettings, canvasPixels: canvasPixels)
            history.append(currentAction)
            if currentAction.id == action.id {
                break
            }
        }
    }
    
    func undo(
        drawSettings: DrawSettings? = nil,
        canvasPixels: CanvasPixels?
    ) {
        switch history.popLast() {
            case Optional.some(let action):
                action.undo(drawSettings: drawSettings, canvasPixels: canvasPixels)
                undoHistory.append(action)
            default: break
        }
    }
    
    func redo(
        drawSettings: DrawSettings? = nil,
        canvasPixels: CanvasPixels?
    ) {
        switch undoHistory.popLast() {
            case Optional.some(let action):
                action.redo(drawSettings: drawSettings, canvasPixels: canvasPixels)
                history.append(action)
            default: break
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
