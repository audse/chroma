//
//  ChangeLayerOpacityAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/26/23.
//

import Foundation

class ChangeLayerOpacityAction: AccumulatableAction {
    let layer: LayerModel
    let prevOpacity: Double
    var newOpacity: Double
    
    init(_ layer: LayerModel, _ newOpacity: Double) {
        self.layer = layer
        self.prevOpacity = layer.opacity
        self.newOpacity = newOpacity
        super.init()
    }
    
    override func accumulate(with next: AccumulatableAction) -> AccumulateResult {
        if let next = next as? Self, layer == next.layer {
            newOpacity = next.newOpacity
            return .success
        }
        return .failure
    }
    
    override func getText() -> String {
        "Opacity"
    }
    
    override func perform() {
        layer.opacity = newOpacity
    }
    
    override func undo() {
        layer.opacity = prevOpacity
    }
    
    override func redo() {
        layer.opacity = newOpacity
    }
}
