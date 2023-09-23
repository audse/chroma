//
//  EraseSelectionAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import Foundation

class EraseSelectionAction: EraseMultipleAction {
    var previousSelection: [LayerPixelModel] = []
    
    override init(_ pixels: [LayerPixelModel], _ layer: LayerModel) {
        self.previousSelection = layer.selectedPixels
        super.init(pixels, layer)
    }
    
    override func perform() {
        super.perform()
        layer.selectedPixels = layer.selectedPixels.intersection(layer.pixels)
    }
    
    override func undo() {
        super.undo()
        layer.selectedPixels = previousSelection
    }
    
    override func redo() {
        super.redo()
        layer.selectedPixels = layer.selectedPixels.intersection(layer.pixels)
    }
}
