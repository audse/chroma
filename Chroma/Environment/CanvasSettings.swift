//
//  CanvasSettings.swift
//  Chroma
//
//  Created by Audrey Serene on 9/13/23.
//

import SwiftUI

class CanvasPixels: ObservableObject {
    @Published var pixels: [Pixel] = []
    
    func pixels(_ value: [Pixel]) -> CanvasPixels {
        pixels = value
        return self
    }
    
    func findPixel(_ value: Pixel) -> Int {
        let index = pixels.firstIndex(where: { pixel in
            pixel.id == value.id
        })
        switch index {
            case Optional.some(let i): return i
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
}

private struct CanvasPixelsKey: EnvironmentKey {
    static var defaultValue = CanvasPixels()
}

private struct CanvasSizeKey: EnvironmentKey {
    static var defaultValue = CGSize(512)
}

private struct CanvasBgColorKey: EnvironmentKey {
    static var defaultValue = Color.white
}

extension EnvironmentValues {
    var canvasPixels: CanvasPixels {
        get { self[CanvasPixelsKey.self] }
        set { self[CanvasPixelsKey.self] = newValue }
    }
    var canvasSize: CGSize {
        get { self[CanvasSizeKey.self] }
        set { self[CanvasSizeKey.self] = newValue }
    }
    var canvasBgColor: Color {
        get { self[CanvasBgColorKey.self] }
        set { self[CanvasBgColorKey.self] = newValue }
    }
}
