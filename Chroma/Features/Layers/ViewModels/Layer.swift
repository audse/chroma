//
//  Layer.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

class Layer: ObservableObject, Identifiable {
    @Published var model: LayerModel
    @Published var pixels: [Pixel]
    
    var onChange: () -> Void
    
    init(_ model: LayerModel, artboard: ArtboardViewModel) {
        self.model = model
        self.pixels = model.pixels.map { pixelModel in Pixel(pixelModel) }
        self.onChange = artboard.objectWillChange.send
    }
    
    func addPixel(_ pixel: Pixel) {
        model.pixels.append(pixel.model)
        pixels.append(pixel)
        onChange()
    }
    
    func insertPixel(_ pixel: Pixel, at index: Int) {
        model.pixels.insert(pixel.model, at: index)
        pixels.insert(pixel, at: index)
        onChange()
    }
    
    func removePixel(_ index: Int) -> Pixel {
        let pixel = pixels.remove(at: index)
        _ = model.pixels.remove(at: index)
        onChange()
        return pixel
    }
    
    func findPixel(_ value: Pixel) -> Int {
        return pixels.firstIndex(where: { pixel in pixel.id == value.id }) ?? -1
    }
    
    func findPixel(_ point: CGPoint) -> Int {
        return pixels.firstIndex(where: { pixel in pixel.getRect().contains(point) }) ?? -1
    }
    
    func draw(_ context: GraphicsContext) {
        if model.isVisible {
            pixels.forEach { pixel in pixel.draw(context) }
        }
    }
    
    func toggle() {
        model.isVisible.toggle()
        onChange()
    }
    
    var isVisible: Bool {
        return model.isVisible
    }
}
