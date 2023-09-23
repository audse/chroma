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
        layer.addPixel(pixel)
    }
    
    override func undo() {
        layer.removePixel(pixel)
    }

    override func redo() {
        if let index = index {
            layer.insertPixel(pixel, at: index)
        }
    }
}
