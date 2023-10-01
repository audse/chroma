//
//  RemoveFilterAction.swift
//  Chroma
//
//  Created by Audrey Serene on 10/1/23.
//

import Foundation

class RemoveFilterAction: Action {
    let filter: LayerFilter
    let layer: LayerModel
    let index: Int?
    
    init(_ filter: LayerFilter, _ layer: LayerModel) {
        self.filter = filter
        self.layer = layer
        self.index = layer.filters.firstIndex(of: filter)
    }
    
    override func getText() -> String {
        "Remove Filter"
    }
    
    override func perform() {
        if let index {
            layer.filters.remove(at: index)
        }
    }
    
    override func undo() {
        if let index {
            layer.filters.insert(filter, at: index)
        }
    }
    
    override func redo() {
        if let index {
            layer.filters.remove(at: index)
        }
    }
}
