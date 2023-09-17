//
//  CurrentArtboardViewModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

class CurrentArtboardViewModel: ObservableObject {
    @Published private var model: CurrentArtboardModel
    
    init(model: CurrentArtboardModel = CurrentArtboardModel()) {
        self.model = model
    }
    
    func withNewLayer(_ pixels: [Pixel] = []) -> CurrentArtboardViewModel {
        model.layer = newLayer(pixels)
        return self
    }
    
    func newLayer(_ pixels: [Pixel] = []) -> Layer {
        let newLayer = Layer(
            name: "Layer \(model.artboard.layers.count)",
            onChange: changed
        ).pixels(pixels)
        model.artboard.layers.append(newLayer)
        changed()
        return newLayer
    }
    
    func getIndex(_ forLayer: Layer) -> Int? {
        return model.artboard.layers.firstIndex(where: { layer in
            return layer.id == forLayer.id
        })
    }
    
    func deleteLayer(_ toDelete: Layer) {
        if model.layer?.id == toDelete.id {
            model.layer = nil
            // set active to previous layer
            if let idx = getIndex(toDelete) {
                if idx > 0 {
                    model.layer = model.artboard.layers[idx - 1]
                }
            }
        }
        model.artboard.layers.removeAll(where: { layer in
            return layer.id == toDelete.id
        })
        changed()
    }
    
    func setLayer(_ layer: Layer) {
        model.layer = layer
        changed()
    }
    
    func resize(_ size: CGSize) {
        model.artboard.size = size
        changed()
    }
    
    func resize(width: CGFloat? = nil, height: CGFloat? = nil) {
        model.artboard.size.width = width ?? model.artboard.size.width
        model.artboard.size.height = height ?? model.artboard.size.height
        changed()
    }
    
    func setBackgroundColor(_ color: Color) {
        model.artboard.backgroundColor = color
        changed()
    }
    
    private func changed() {
        objectWillChange.send()
    }
    
    var size: CGSize {
        return model.artboard.size
    }
    
    var backgroundColor: Color {
        return model.artboard.backgroundColor
    }
    
    var currentLayer: Layer? {
        return model.layer
    }
    
    var layers: [Layer] {
        return model.artboard.layers
    }
}

private struct CurrentArtboardKey: EnvironmentKey {
    static var defaultValue = CurrentArtboardViewModel()
}

extension EnvironmentValues {
    var currentArtboard: CurrentArtboardViewModel {
        get { self[CurrentArtboardKey.self] }
        set { self[CurrentArtboardKey.self] = newValue }
    }
}
