//
//  DerivedData.swift
//  Chroma
//
//  Created by Audrey Serene on 9/22/23.
//

import Foundation

extension History {
    /**
     Scans the history to get the most recently selected pixels on the current layer.
     */
    func getCurrentSelection() -> [LayerPixelModel] {
        if let currentLayer = getCurrentLayer() {
            var pixels = [LayerPixelModel]()
            if currentLayer.isVisible {
                history.forEach { action in
                    if action is EraseSelectionAction {
                        pixels = []
                    }
                    if action is DeselectAllAction {
                        pixels = []
                    }
                    if let action = action as? SelectAction {
                        pixels = action.pixels
                    }
                    if let action = action as? PasteAction {
                        pixels = action.pixels
                    }
                }
                return pixels.filter(currentLayer.pixels.contains)
            }
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
    
    func getPreviousTool() -> Tool {
        let actions = history.reversed().filterMap { $0 as? SelectToolAction }
        return actions.get(at: 1)?.tool ?? .draw(.positive)
    }
    
    func getCopiedPixels() -> [LayerPixelModel] {
        for action in history.reversed() {
            if let action = action as? CopyAction {
                return action.pixels
            }
            if let action = action as? CutAction {
                return action.pixels
            }
        }
        return []
    }
}
