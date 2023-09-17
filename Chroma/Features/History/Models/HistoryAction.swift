//
//  HistoryAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import Foundation

class Action: Identifiable {
    var id = UUID()
    func undo() {}
    func redo() {}
}

class DrawAction: Action {
    var pixel: Pixel
    var index: Int = -1
    var layer: Layer
    
    init(_ pixelValue: Pixel, _ layerValue: Layer) {
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
    var pixel: Pixel
    var index: Int
    var layer: Layer
    
    init(_ pixelValue: Pixel, _ indexValue: Int, _ layerValue: Layer) {
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
