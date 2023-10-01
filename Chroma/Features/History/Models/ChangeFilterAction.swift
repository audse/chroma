//
//  ChangeFilterAction.swift
//  Chroma
//
//  Created by Audrey Serene on 10/1/23.
//

import Foundation

class ChangeFilterAction: AccumulatableAction {
    var filter: LayerFilter
    let prevFilter: LayerFilter?
    let index: Int?
    let layer: LayerModel
    
    init(_ filter: LayerFilter, _ layer: LayerModel) {
        self.filter = filter
        self.index = layer.filters.firstIndex(of: filter)
        self.layer = layer
        if let index = self.index {
            self.prevFilter = layer.filters[index]
        } else {
            self.prevFilter = nil
        }
    }
    
    override func getText() -> String {
        "Change Filter"
    }
    
    override func accumulate(with next: AccumulatableAction) -> AccumulatableAction.AccumulateResult {
        if let next = next as? Self, next.layer == layer, next.filter.id == filter.id {
            self.filter = next.filter
            return .success
        }
        return .failure
    }
    
    override func perform() {
        if let index {
            layer.filters[index] = filter
        }
    }
    
    override func undo() {
        if let index, let prevFilter {
            layer.filters[index] = prevFilter
        }
    }
    
    override func redo() {
        if let index {
            layer.filters[index] = filter
        }
    }
}
