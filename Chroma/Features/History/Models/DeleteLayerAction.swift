//
//  DeleteLayerAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/22/23.
//

import SwiftUI

class DeleteLayerAction: Action {
    let layer: LayerModel
    let artboard: ArtboardModel
    var index: Int?
    
    init(_ layer: LayerModel, _ artboard: ArtboardModel) {
        self.layer = layer
        self.artboard = artboard
        super.init()
    }
    
    override func getText() -> String {
        return "Delete Layer"
    }
    
    override func perform() {
        index = artboard.getIndex(layer)
        artboard.deleteLayer(layer)
    }
    
    override func undo() {
        if let index {
            artboard.insertLayer(layer, at: index)
        }
    }
    
    override func redo() {
        artboard.deleteLayer(layer)
    }
}
