//
//  EraseAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import Foundation

class EraseAction: Action {
    var pixel: PixelModel
    var index: Int
    var layer: LayerModel

    init(_ pixelValue: PixelModel, _ indexValue: Int, _ layerValue: LayerModel) {
        pixel = pixelValue
        index = indexValue
        layer = layerValue
        super.init()
    }

    override func getText() -> String {
        return "Erase"
    }
    
    override func perform() {
        _ = layer.removePixel(index)
    }

    override func undo() {
        if index != -1 {
            layer.insertPixel(pixel, at: index)
        }
    }

    override func redo() {
        perform()
    }
}
