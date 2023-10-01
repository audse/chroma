//
//  AddFilterAction.swift
//  Chroma
//
//  Created by Audrey Serene on 10/1/23.
//

import Foundation

class AddFilterAction: Action {
    let filter: LayerFilter
    let layer: LayerModel
    var index: Int?
    
    init(_ filter: LayerFilter, _ layer: LayerModel) {
        self.filter = filter
        self.layer = layer
    }
    
    override func getText() -> String {
        "Add Filter"
    }
    
    override func perform() {
        index = layer.filters.count
        layer.filters.append(filter)
    }
    
    override func undo() {
        if let index {
            layer.filters.remove(at: index)
        }
    }
    
    override func redo() {
        if let index {
            layer.filters.insert(filter, at: index)
        }
    }
}
