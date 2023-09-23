//
//  DerivedData.swift
//  Chroma
//
//  Created by Audrey Serene on 9/22/23.
//

import Foundation

// swiftlint:disable force_cast

extension History {
    /**
     Scans the history to get the most recently selected pixels on the current layer.
     */
    func getCurrentSelection() -> [LayerPixelModel] {
        if let currentLayer = getCurrentLayer() {
            var pixels = [LayerPixelModel]()
            history.forEach { action in
                if let action = action as? EraseSelectionAction {
                    pixels = []
                }
                if let action = action as? DeselectAllAction {
                    pixels = []
                }
                if let action = action as? SelectAction {
                    pixels = action.pixels
                }
            }
            return pixels.filter(currentLayer.pixels.contains)
        }
        return []
    }
    
    /**
     Scans the history to get the most recently selected layer.
     */
    func getCurrentLayer() -> LayerModel? {
        for action in history.reversed() {
            if let action = action as? SelectLayerAction {
                return action.layer
            }
            if let action = action as? NewLayerAction {
                return action.layer
            }
            if let action = action as? DeleteLayerAction {
                if let index = action.index {
                    return action.artboard.layers.get(at: index - 1)
                }
            }
        }
        return nil
    }
}
