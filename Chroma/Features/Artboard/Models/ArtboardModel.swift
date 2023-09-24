//
//  ArtboardModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI
import Combine

public final class ArtboardModel: ObservableObject, Identifiable {
    public let id: UUID
    @Published public var name: String?
    @Published public var size: CGSize
    @Published public var backgroundColor: Color
    
    private var _layerCancellables: [AnyCancellable] = []
    @Published public var layers: [LayerModel] {
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
}

extension ArtboardModel: Codable {
    internal enum CodingKeys: CodingKey {
        case id
        case name
        case size
        case backgroundColor
        case layers
    }
    
    public convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.init(
            id: try values.decode(UUID.self, forKey: .id),
            name: try values.decode(String?.self, forKey: .name),
            size: try values.decode(CGSize.self, forKey: .size),
            backgroundColor: try values.decode(Color.self, forKey: .backgroundColor),
            layers: try values.decode([LayerModel].self, forKey: .layers)
        )
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(size, forKey: .size)
        try container.encode(backgroundColor, forKey: .backgroundColor)
        try container.encode(layers, forKey: .layers)
    }
}

extension ArtboardModel {
    func withNewLayer(_ pixels: [LayerPixelModel] = []) -> ArtboardModel {
        _ = newLayer(pixels)
        return self
    }

    func newLayer(_ pixels: [LayerPixelModel] = []) -> LayerModel {
        let newLayer = LayerModel(name: "Layer \(layers.count)", pixels: pixels)
        layers.append(newLayer)
        return newLayer
    }

    func resize(width: CGFloat? = nil, height: CGFloat? = nil) {
        size.width = width ?? size.width
        size.height = height ?? size.height
    }
    
    func moveLayer(_ layer: LayerModel, to newIndex: Int) {
        if let index = layers.firstIndex(of: layer) {
            layers.move(fromOffsets: [index], toOffset: newIndex)
            objectWillChange.send()
        }
    }

    var visibleLayers: [LayerModel] {
        return layers.filter { layer in layer.isVisible }
    }
}
