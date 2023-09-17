//
//  CanvasSettings.swift
//  Chroma
//
//  Created by Audrey Serene on 9/13/23.
//

import SwiftUI

class Layer: Identifiable {
    var id = UUID()
    var name = "Layer"
    var pixels: [Pixel] = []
    var onChange: () -> Void
    
    var isVisible: Bool = true
    
    init(
        name: String = "Layer",
        pixels: [Pixel] = [],
        onChange: @escaping () -> Void = {}
    ) {
        self.name = name
        self.pixels = pixels
        self.onChange = onChange
    }
    
    func pixels(_ value: [Pixel]) -> Layer {
        self.pixels = value
        return self
    }
    
    func addPixel(_ pixel: Pixel) {
        pixels.append(pixel)
        onChange()
    }
    
    func insertPixel(_ pixel: Pixel, at index: Int) {
        pixels.insert(pixel, at: index)
        onChange()
    }
    
    func removePixel(_ index: Int) -> Pixel {
        let pixel = pixels.remove(at: index)
        onChange()
        return pixel
    }
    
    func findPixel(_ value: Pixel) -> Int {
        let index = pixels.firstIndex(where: { pixel in
            pixel.id == value.id
        })
        switch index {
            case .some(let i): return i
            default: return -1
        }
    }
    
    func findPixel(_ point: CGPoint) -> Int {
        for (i, pixel) in pixels.enumerated() {
            if (pixel.getRect().contains(point)) {
                return i
            }
        }
        return -1
    }
    
    func toggle() {
        isVisible = !isVisible
        onChange()
    }
}

class CurrentCanvas: ObservableObject {
    @Published var layers: [Layer] = []
    @Published var currentLayer: Layer? = nil
    
    func withNewLayer(_ pixels: [Pixel] = []) -> CurrentCanvas {
        currentLayer = newLayer(pixels)
        return self
    }
    
    func newLayer(_ pixels: [Pixel] = []) -> Layer {
        let newLayer = Layer(
            name: "Layer \(layers.count)",
            onChange: { self.objectWillChange.send() }
        ).pixels(pixels)
        layers.append(newLayer)
        return newLayer
    }
    
    func getIndex(_ forLayer: Layer) -> Int? {
        return layers.firstIndex(where: { layer in
            return layer.id == forLayer.id
        })
    }
    
    func deleteLayer(_ toDelete: Layer) {
        if currentLayer?.id == toDelete.id {
            currentLayer = nil
            // set active to previous layer
            if let idx = getIndex(toDelete) {
                if idx > 0 {
                    currentLayer = layers[idx - 1]
                }
            }
        }
        layers.removeAll(where: { layer in
            return layer.id == toDelete.id
        })
    }
}

private struct CurrentCanvasKey: EnvironmentKey {
    static var defaultValue = CurrentCanvas()
}

private struct CanvasSizeKey: EnvironmentKey {
    static var defaultValue = Binding.constant(CGSize(512))
}

private struct CanvasBgColorKey: EnvironmentKey {
    static var defaultValue = Binding.constant(Color.white)
}

extension EnvironmentValues {
    var currentCanvas: CurrentCanvas {
        get { self[CurrentCanvasKey.self] }
        set { self[CurrentCanvasKey.self] = newValue }
    }
    var canvasSize: Binding<CGSize> {
        get { self[CanvasSizeKey.self] }
        set { self[CanvasSizeKey.self] = newValue }
    }
    var canvasBgColor: Binding<Color> {
        get { self[CanvasBgColorKey.self] }
        set { self[CanvasBgColorKey.self] = newValue }
    }
}
