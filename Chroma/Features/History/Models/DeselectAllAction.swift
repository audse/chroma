//
//  DeselectAllAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import Foundation

class DeselectAllAction: Action {
    var previousSelection: [PixelModel] = []
    var layer: LayerModel
    
    init(_ layer: LayerModel) {
        self.previousSelection = layer.selectedPixels
        self.layer = layer
        super.init()
    }
    
    override func getText() -> String {
        return "Deselect"
    }
    
    override func perform() {
        layer.selectedPixels = []
    }
    
    override func undo() {
        layer.selectedPixels = previousSelection
    }
    
    override func redo() {
        layer.selectedPixels = []
    }
}
