//
//  ArtboardViewModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

class ArtboardViewModel: ObservableObject, Identifiable {
    @Published var artboard: ArtboardModel
    @Published var layers: [Layer] = []
    @Published var layer: Layer? = nil
    
    init(_ model: ArtboardModel = ArtboardModel()) {
        self.artboard = model
        self.layers = model.layers.map { layerModel in Layer(layerModel, artboard: self) }
    }
    
    func setModel(_ model: ArtboardModel) {
        self.artboard = model
        self.layers = model.layers.map { layerModel in Layer(layerModel, artboard: self) }
        self.layer = self.layers.count > 0 ? self.layers[0] : nil
    }
    
    func withNewLayer(_ pixels: [PixelModel] = []) -> ArtboardViewModel {
        layer = newLayer(pixels)
        return self
    }
    
    func newLayer(_ pixels: [PixelModel] = []) -> Layer {
        let newLayer = Layer(
            LayerModel(
                name: "Layer \(artboard.layers.count)",
                pixels: pixels
            ),
            artboard: self
        )
        addLayer(newLayer)
        changed()
        return newLayer
    }
    
    func addLayer(_ layer: Layer) {
        artboard.layers.append(layer.model)
        layers.append(layer)
    }
    
    func removeLayer(at index: Int) {
        artboard.layers.remove(at: index)
        layers.remove(at: index)
    }
    
    func removeLayer(_ layer: Layer) {
        if let index = getIndex(layer) {
            artboard.layers.remove(at: index)
            layers.remove(at: index)
        }
    }
    
    func getIndex(_ forLayer: Layer) -> Int? {
        return layers.firstIndex(where: { layer in layer.id == forLayer.id })
    }
    
    func deleteLayer(_ toDelete: Layer) {
        // delete active layer
        if layer?.id == toDelete.id {
            layer = nil
            // set active to previous layer
            if let idx = getIndex(toDelete) {
                if idx > 0 && idx < layers.count {
                    layer = layers[idx - 1]
                }
            }
        }
        removeLayer(toDelete)
        changed()
    }
    
    func setLayer(_ layer: Layer) {
        self.layer = layer
    }
    
    func resize(_ size: CGSize) {
        artboard.size = size
        changed()
    }
    
    func resize(width: CGFloat? = nil, height: CGFloat? = nil) {
        artboard.size.width = width ?? artboard.size.width
        artboard.size.height = height ?? artboard.size.height
        changed()
    }
    
    func setBackgroundColor(_ color: Color) {
        artboard.backgroundColor = color
        changed()
    }
    
    private func changed() {
        objectWillChange.send()
    }
    
    var id: UUID {
        return artboard.id
    }
    
    var size: CGSize {
        return artboard.size
    }
    
    var backgroundColor: Color {
        return artboard.backgroundColor
    }
}

private struct ArtboardKey: EnvironmentKey {
    static var defaultValue = ArtboardViewModel()
}

extension EnvironmentValues {
    var currentArtboard: ArtboardViewModel {
        get { self[ArtboardKey.self] }
        set { self[ArtboardKey.self] = newValue }
    }
}
