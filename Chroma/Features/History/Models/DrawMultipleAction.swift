//
//  DrawMultipleAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import Foundation

class DrawMultipleAction: Action {
    var pixels: [LayerPixelModel] = []
    var layer: LayerModel
    var startIndex: Int?

    init(_ pixels: [LayerPixelModel], _ layer: LayerModel) {
        self.pixels = pixels
        self.layer = layer
        super.init()
    }
    
    override func getText() -> String {
        return "Draw"
    }
    
    override func perform() {
        pixels.forEach(layer.addPixel)
        if let firstPixel = pixels.first {
            self.startIndex = layer.findPixel(firstPixel)
        }
    }

    override func undo() {
        layer.pixels = layer.pixels.filterOut(pixels.contains)
    }

    override func redo() {
        if let startIndex = startIndex {
            layer.insertPixels(pixels, at: startIndex)
        }
    }
}

class LineAction: DrawMultipleAction {
    override func getText() -> String {
        return "Line"
    }
}

class RectAction: DrawMultipleAction {
    override func getText() -> String {
        return "Rect"
    }
}
