//
//  ChangeArtboardSizeAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/26/23.
//

import Foundation

class ChangeArtboardSizeAction: AccumulatableAction {
    let artboard: ArtboardModel
    let prevSize: CGSize
    var newSize: CGSize
    
    init(_ artboard: ArtboardModel, _ newSize: CGSize) {
        self.artboard = artboard
        self.prevSize = artboard.size
        self.newSize = newSize
        super.init()
    }
    
    override func getText() -> String {
        "Resize"
    }
    
    override func accumulate(with next: AccumulatableAction) -> AccumulateResult {
        if let next = next as? Self, next.artboard == artboard {
            newSize = next.newSize
            return .success
        }
        return .failure
    }
    
    override func perform() {
        artboard.size = newSize
    }
    
    override func undo() {
        artboard.size = prevSize
    }
    
    override func redo() {
        artboard.size = newSize
    }
}
