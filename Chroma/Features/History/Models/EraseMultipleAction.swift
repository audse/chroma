//
//  EraseMultipleAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import Foundation

class EraseMultipleAction: Action {
    var pixels: [LayerPixelModel] = []
    var layer: LayerModel
    var startIndex: Int?

    init(_ pixels: [LayerPixelModel], _ layer: LayerModel) {
        self.pixels = pixels
        self.layer = layer
        super.init()
    }
    
    override func getText() -> String {
        return "Erase"
    }
    
    override func perform() {
        if let firstPixel = pixels.first {
            self.startIndex = layer.findPixel(firstPixel)
        }
        layer.pixels = layer.pixels.filterOut(pixels.contains)
    }

    override func undo() {
        if let startIndex = startIndex {
            layer.pixels.insert(contentsOf: pixels, at: startIndex)
        }
    }

    override func redo() {
        layer.pixels.removeEach(pixels)
    }
}
