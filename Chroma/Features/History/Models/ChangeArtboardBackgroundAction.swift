//
//  ChangeArtboardBackgroundAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/25/23.
//

import SwiftUI

class ChangeArtboardBackgroundAction: Action {
    let artboard: ArtboardModel
    let prevColor: Color
    let newColor: Color
    
    init(_ artboard: ArtboardModel, _ newColor: Color) {
        self.artboard = artboard
        self.prevColor = artboard.backgroundColor
        self.newColor = newColor
        super.init()
    }
    
    override func getText() -> String {
        "Set BG"
    }
    
    override func perform() {
        artboard.backgroundColor = newColor
    }
    
    override func undo() {
        artboard.backgroundColor = prevColor
    }
    
    override func redo() {
        artboard.backgroundColor = newColor
    }
}
