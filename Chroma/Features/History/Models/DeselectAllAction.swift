//
//  DeselectAllAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import Foundation

class DeselectAllAction: Action {
    var layer: LayerModel
    
    init(_ layer: LayerModel) {
        self.layer = layer
        super.init()
    }
    
    override func getText() -> String {
        return "Deselect"
    }
}
