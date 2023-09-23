//
//  MoveAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import Foundation

class MoveAction: Action {
    var pixels: [LayerPixelModel]
    var originalPositions: [CGPoint]
    var delta: CGPoint
    
    var snapFn: (CGPoint) -> CGPoint
    
    init(_ pixels: [LayerPixelModel], drawSettings: DrawSettings, delta: CGPoint) {
        self.pixels = pixels
        self.delta = delta
        self.originalPositions = pixels.map { pixel in pixel.position }
        self.snapFn = drawSettings.snapped
        super.init()
    }
    
    override func getText() -> String {
        return "Move"
    }
    
    override func perform() {
        pixels.forEach { pixel in
            pixel.setPosition(snapFn(pixel.position + delta))
        }
    }
    
    override func undo() {
        pixels.enumerated().forEach { (index, pixel) in
            pixel.setPosition(originalPositions[index])
        }
    }
    
    override func redo() {
        perform()
    }
}
