//
//  HistoryAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

class Action: Identifiable {
    var id = UUID()
    func undo() {}
    func redo() {}
}

class DrawAction: Action {
    var pixel: PixelModel
    var index: Int = -1
    var layer: LayerModel
    
    init(_ pixelValue: PixelModel, _ layerValue: LayerModel) {
        pixel = pixelValue
        layer = layerValue
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

class EraseAction: Action {
    var pixel: PixelModel
    var index: Int
    var layer: LayerModel
    
    init(_ pixelValue: PixelModel, _ indexValue: Int, _ layerValue: LayerModel) {
        pixel = pixelValue
        index = indexValue
        layer = layerValue
    }
    
    override func undo() {
        if index != -1 {
            layer.insertPixel(pixel, at: index)
        }
    }
    
    override func redo() {
        _ = layer.removePixel(index)
    }
}

class FillAction: Action {
    var originalColor: Color
    var newColor: Color
    var pixel: PixelModel
    
    init(_ pixelValue: PixelModel, originalColor: Color, newColor: Color) {
        pixel = pixelValue
        self.originalColor = originalColor
        self.newColor =  newColor
    }
    
    override func undo() {
        pixel.setColor(originalColor)
    }
    
    override func redo() {
        pixel.setColor(newColor)
    }
}
