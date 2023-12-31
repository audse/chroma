//
//  DrawAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import Foundation

class DrawAction: Action {
    var pixel: LayerPixelModel
    var index: Int?
    var layer: LayerModel

    init(_ pixel: LayerPixelModel, _ layer: LayerModel) {
        self.pixel = pixel
        self.layer = layer
        super.init()
    }

    override func getText() -> String {
        return "Draw"
    }
    
    override func perform() {
        index = layer.pixels.count
        layer.pixels.append(pixel)
    }
    
    override func undo() {
        layer.pixels.remove(pixel)
    }

    override func redo() {
        if let index = index {
            layer.pixels.insert(pixel, at: index)
        }
    }
}
