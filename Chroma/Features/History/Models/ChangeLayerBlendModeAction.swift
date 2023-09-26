//
//  ChangeLayerBlendModeAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/26/23.
//

import SwiftUI

class ChangeLayerBlendModeAction: AccumulatableAction {
    let layer: LayerModel
    let prevBlendMode: BlendMode
    var newBlendMode: BlendMode
    
    init(_ layer: LayerModel, _ newBlendMode: BlendMode) {
        self.layer = layer
        self.prevBlendMode = layer.blendMode
        self.newBlendMode = newBlendMode
        super.init()
    }
    
    override func accumulate(with next: AccumulatableAction) -> AccumulateResult {
        if let next = next as? Self {
            newBlendMode = next.newBlendMode
            return .success
        }
        return.failure
    }
    
    override func getText() -> String {
        "Blend Mode"
    }
    
    override func perform() {
        layer.blendMode = newBlendMode
    }
    
    override func undo() {
        layer.blendMode = prevBlendMode
    }
    
    override func redo() {
        layer.blendMode = newBlendMode
    }
}
