//
//  ToggleLayerLockAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/23/23.
//

import Foundation

class ToggleLayerLockAction: Action {
    let layer: LayerModel
    let initialState: Bool
    
    init(_ layer: LayerModel) {
        self.layer = layer
        self.initialState = layer.isLocked
        super.init()
    }
    
    override func getText() -> String {
        switch initialState {
        case true: return "Unlock Layer"
        case false: return "Lock Layer"
        }
    }
    
    override func perform() {
        layer.isLocked.toggle()
    }
    
    override func undo() {
        layer.isLocked.toggle()
    }
    
    override func redo() {
        layer.isLocked.toggle()
    }
}
