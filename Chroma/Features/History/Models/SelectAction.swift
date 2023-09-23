//
//  SelectAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import Foundation

class SelectAction: Action {
    var pixels: [LayerPixelModel] = []
    var layer: LayerModel
    
    init(_ pixels: [LayerPixelModel], _ layer: LayerModel) {
        self.pixels = pixels
        self.layer = layer
        super.init()
    }
    
    override func getText() -> String {
        return "Select"
    }
}
