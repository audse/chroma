//
//  SelectLayerAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/22/23.
//

import Foundation

class SelectLayerAction: Action {
    let layer: LayerModel?
    
    init(_ layer: LayerModel?) {
        self.layer = layer
    }
    
    override func isSilent() -> Bool {
        return true
    }
}
