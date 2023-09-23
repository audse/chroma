//
//  NewLayerAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/22/23.
//

import SwiftUI

class NewLayerAction: Action {
    var layer: LayerModel?
    var index: Int?
    let artboard: ArtboardModel
    
    init(_ artboard: ArtboardModel) {
        self.artboard = artboard
        super.init()
    }
    
    override func getText() -> String {
        return "New Layer"
    }
    
    override func perform() {
        index = artboard.layers.count
        layer = artboard.newLayer()
    }
    
    override func undo() {
        if let layer {
            artboard.layers.remove(layer)
        }
    }
    
    override func redo() {
        if let layer, let index {
            artboard.layers.insert(layer, at: index)
        }
    }
}
