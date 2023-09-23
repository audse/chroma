//
//  FillAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

class FillAction: Action {
    var originalColor: Color
    var newColor: Color
    var pixels: [LayerPixelModel]

    init(_ pixels: [LayerPixelModel], originalColor: Color, newColor: Color) {
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
