//
//  EraseAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import Foundation

class EraseAction: Action {
    var pixel: LayerPixelModel
    var index: Int?
    var layer: LayerModel

    init(_ pixel: LayerPixelModel, _ layer: LayerModel) {
        self.pixel = pixel
        self.layer = layer
        self.index = layer.findPixel(pixel)
        super.init()
    }

    override func getText() -> String {
        return "Erase"
    }
    
    override func perform() {
        layer.removePixel(pixel)
    }

    override func undo() {
        if let index = index {
            layer.insertPixel(pixel, at: index)
        }
    }

    override func redo() {
        perform()
    }
}
