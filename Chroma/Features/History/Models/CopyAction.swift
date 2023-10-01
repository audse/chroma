//
//  CopyAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/29/23.
//

import Foundation

class CopyAction: EditorAction {
    let pixels: [LayerPixelModel]
    
    init(_ pixels: [LayerPixelModel]) {
        self.pixels = pixels
    }
}
