//
//  HistoryAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

class Action: Identifiable {
    var id = UUID()
    func getText() -> String {
        return "Action"
    }
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
    
    override func getText() -> String {
        return "Draw"
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
    
    override func getText() -> String {
        return "Erase"
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
    var pixels: [PixelModel]
    
    init(_ pixels: [PixelModel], originalColor: Color, newColor: Color) {
        self.pixels = pixels
        self.originalColor = originalColor
        self.newColor =  newColor
    }
    
    override func getText() -> String {
        return "Fill"
    }
    
    override func undo() {
        pixels.forEach { pixel in pixel.setColor(originalColor) }
    }
    
    override func redo() {
        pixels.forEach { pixel in pixel.setColor(newColor) }
    }
}

class DrawMultipleAction: Action {
    var pixels: [PixelModel] = []
    var layer: LayerModel
    var indices: [Int] = []
    
    init(_ pixels: [PixelModel], _ layer: LayerModel) {
        self.pixels = pixels
        self.layer = layer
        self.indices = pixels.map(layer.findPixel)
    }
    
    override func undo() {
        indices.sorted().reversed().forEach { index in _ = layer.removePixel(index) }
    }
    
    override func redo() {
        indices.sorted().enumerated().forEach { (i, index) in
            layer.insertPixel(pixels[i], at: index)
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
