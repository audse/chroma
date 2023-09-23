//
//  ArtboardModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI
import Combine

class ArtboardModel: ObservableObject, Identifiable {
    var id: UUID
    @Published var name: String?
    @Published var size: CGSize
    @Published var backgroundColor: Color
    @Published private(set) var layers: [LayerModel]
    @Published var currentLayer: LayerModel?

    private var _layerCancellables: [AnyCancellable] = []

    init(
        id: UUID = UUID(),
        name: String? = nil,
        size: CGSize = CGSize(512),
        backgroundColor: Color = .white,
        layers: [LayerModel] = []
    ) {
        self.id = id
        self.name = name
        self.size = size
        self.backgroundColor = backgroundColor
        self.layers = layers

    }

    private func _subscribe(_ layer: LayerModel) {
        _layerCancellables.append(layer.objectWillChange.sink { _ in self.objectWillChange.send() })
    }

    func withNewLayer(_ pixels: [LayerPixelModel] = []) -> ArtboardModel {
        currentLayer = newLayer(pixels)
        return self
    }

    func newLayer(_ pixels: [LayerPixelModel] = []) -> LayerModel {
        let newLayer = LayerModel(
            name: "Layer \(layers.count)",
            pixels: pixels
        )
        addLayer(newLayer)
        return newLayer
    }

    func addLayer(_ layer: LayerModel) {
        layers.append(layer)
        _subscribe(layer)
    }

    func removeLayer(_ layer: LayerModel) {
        if let index = getIndex(layer) {
            layers.remove(at: index)
        }
    }

    func getIndex(_ forLayer: LayerModel) -> Int? {
        return layers.firstIndex(where: { layer in layer.id == forLayer.id })
    }

    func deleteLayer(_ toDelete: LayerModel) {
        // delete active layer
        if currentLayer?.id == toDelete.id {
            currentLayer = nil
            // set active to previous layer
            if let idx = getIndex(toDelete) {
                if idx > 0 && idx < layers.count {
                    currentLayer = layers[idx - 1]
                }
            }
        }
        layers.removeAll { layer in layer.id == toDelete.id }
    }

    func resize(width: CGFloat? = nil, height: CGFloat? = nil) {
        self.size.width = width ?? self.size.width
        self.size.height = height ?? self.size.height
    }

    var visibleLayers: [LayerModel] {
        return layers.filter { layer in layer.isVisible }
    }
}
