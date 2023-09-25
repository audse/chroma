//
//  MoveLayerAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/25/23.
//

import Foundation

class MoveLayerAction: Action {
    let layer: LayerModel
    let artboard: ArtboardModel
    let newIndex: Int
    let prevIndex: Int?
    
    init(_ layer: LayerModel, _ artboard: ArtboardModel, to index: Int) {
        self.layer = layer
        self.artboard = artboard
        self.newIndex = index
        self.prevIndex = artboard.layers.firstIndex(of: layer)
        super.init()
    }
    
    override func getText() -> String {
        "Move Layer"
    }
    
    override func perform() {
        artboard.moveLayer(layer, to: newIndex)
        print(artboard.layers.map { $0.name })
    }
    
    override func undo() {
        if let prevIndex {
            let actualIndex = (
                newIndex < prevIndex ? prevIndex + 1
                : prevIndex
            )
            artboard.moveLayer(layer, to: actualIndex)
            print(artboard.layers.map { $0.name })
        }
    }
    
    override func redo() {
        artboard.moveLayer(layer, to: newIndex)
    }
}
