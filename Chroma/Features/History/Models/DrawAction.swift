//
//  DrawAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import Foundation

class DrawAction: Action {
    var pixel: PixelModel
    var index: Int = -1
    var layer: LayerModel

    init(_ pixel: PixelModel, _ layer: LayerModel) {
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
        index = layer.findPixel(pixel)
        if index != -1 {
            _ = layer.removePixel(index)
        }
    }

    override func redo() {
        if index != -1 {
            layer.insertPixel(pixel, at: index)
        }
    }
}
