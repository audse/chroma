//
//  PasteAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/29/23.
//

import Foundation

class PasteAction: DrawMultipleAction {
    override init(_ pixels: [LayerPixelModel], _ layer: LayerModel) {
        super.init(pixels.map { pixel in pixel.duplicate() }, layer)
    }
    
    override func getText() -> String {
        "Paste"
    }
}
