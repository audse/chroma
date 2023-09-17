//
//  Layer.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import Foundation

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
