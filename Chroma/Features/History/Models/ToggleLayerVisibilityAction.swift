//
//  ToggleLayerVisibilityAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/23/23.
//

import Foundation

class ToggleLayerVisibilityAction: Action {
    let layer: LayerModel
    let initialState: Bool
    
    init(_ layer: LayerModel) {
        self.layer = layer
        self.initialState = layer.isVisible
        super.init()
    }
    
    override func getText() -> String {
        switch initialState {
        case true: return "Hide Layer"
        case false: return "Show Layer"
        }
    }
    
    override func perform() {
        layer.toggle()
    }
    
    override func undo() {
        layer.toggle()
    }
    
    override func redo() {
        layer.toggle()
    }
}
