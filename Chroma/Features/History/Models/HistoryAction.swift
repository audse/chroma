//
//  HistoryAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

class Action: Identifiable {
    var id = UUID()
    
    init() {
        self.perform()
    }
    
    func getText() -> String {
        return "Action"
    }
    func perform() {}
    func undo() {}
    func redo() {}
}

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

class FillAction: Action {
    var originalColor: Color
    var newColor: Color
    var pixels: [PixelModel]

    init(_ pixels: [PixelModel], originalColor: Color, newColor: Color) {
        self.pixels = pixels
        self.originalColor = originalColor
        self.newColor =  newColor
        super.init()
    }

    override func getText() -> String {
        return "Fill"
    }
    
    override func perform() {
        pixels.forEach { pixel in pixel.setColor(newColor) }
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
    var startIndex: Int = -1

    init(_ pixels: [PixelModel], _ layer: LayerModel) {
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
        if startIndex != -1 {
            layer.insertPixels(pixels, at: startIndex)
        }
    }
}

class EraseMultipleAction: Action {
    var pixels: [PixelModel] = []
    var layer: LayerModel
    var startIndex: Int = -1

    init(_ pixels: [PixelModel], _ layer: LayerModel) {
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
        if startIndex != -1 {
            layer.insertPixels(pixels, at: startIndex)
        }
    }

    override func redo() {
        layer.pixels = layer.pixels.filterOut(pixels.contains)
    }
}

class EraseSelectionAction: EraseMultipleAction {
    var previousSelection: [PixelModel] = []
    
    override init(_ pixels: [PixelModel], _ layer: LayerModel) {
        self.previousSelection = layer.selectedPixels
        super.init(pixels, layer)
    }
    
    override func perform() {
        super.perform()
        layer.selectedPixels = layer.selectedPixels.intersection(layer.pixels)
    }
    
    override func undo() {
        super.undo()
        layer.selectedPixels = previousSelection
    }
    
    override func redo() {
        super.redo()
        layer.selectedPixels = layer.selectedPixels.intersection(layer.pixels)
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

class SelectAction: Action {
    var pixels: [PixelModel] = []
    var previousSelection: [PixelModel] = []
    var layer: LayerModel
    
    init(_ pixels: [PixelModel], _ layer: LayerModel) {
        self.pixels = pixels
        self.previousSelection = layer.selectedPixels
        self.layer = layer
        super.init()
    }
    
    override func getText() -> String {
        return "Select"
    }
    
    override func perform() {
        layer.selectedPixels = pixels
    }
    
    override func undo() {
        layer.selectedPixels = previousSelection
    }
    
    override func redo() {
        layer.selectedPixels = pixels
    }
}

class RectSelectAction: SelectAction {}
