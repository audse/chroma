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
    
    private var _layerCancellables: [AnyCancellable] = []
    @Published private(set) var layers: [LayerModel] {
        didSet { _layerCancellables = layers.map { layer in
            layer.objectWillChange.sink { _ in self.objectWillChange.send() }
        } }
    }

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

    func withNewLayer(_ pixels: [LayerPixelModel] = []) -> ArtboardModel {
        _ = newLayer(pixels)
        return self
    }

    func newLayer(_ pixels: [LayerPixelModel] = []) -> LayerModel {
        let newLayer = LayerModel(name: "Layer \(layers.count)", pixels: pixels)
        addLayer(newLayer)
        return newLayer
    }

    func addLayer(_ layer: LayerModel) {
        layers.append(layer)
    }
    
    func insertLayer(_ layer: LayerModel, at index: Int) {
        layers.insert(layer, at: index)
    }

    func removeLayer(_ layer: LayerModel) {
        layers.remove(layer)
    }

    func getIndex(_ layer: LayerModel) -> Int? {
        return layers.firstIndex(of: layer)
    }

    func resize(width: CGFloat? = nil, height: CGFloat? = nil) {
        size.width = width ?? size.width
        size.height = height ?? size.height
    }

    var visibleLayers: [LayerModel] {
        return layers.filter { layer in layer.isVisible }
    }
}
