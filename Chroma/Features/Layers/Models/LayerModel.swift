//
//  LayerModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI
import Combine

class LayerModel: ObservableObject, Identifiable {
    var id = UUID()
    @Published var name = "Layer"
    @Published var pixels: [PixelModel] = []
    @Published var isVisible: Bool = true

    private var _pixelCancellables: [AnyCancellable] = []

    init(
        id: UUID = UUID(),
        name: String = "Layer",
        pixels: [PixelModel] = [],
        isVisible: Bool = true
    ) {
        self.id = id
        self.name = name
        self.pixels = pixels
        self.isVisible = isVisible

        pixels.forEach(_subscribe)
    }

    private func _subscribe(_ pixel: PixelModel) {
        _pixelCancellables.append(pixel.objectWillChange.sink { _ in self.objectWillChange.send() })
    }

    func addPixel(_ pixel: PixelModel) {
        pixels.append(pixel)
        _subscribe(pixel)
    }

    func insertPixel(_ pixel: PixelModel, at index: Int) {
        pixels.insert(pixel, at: index)
        _subscribe(pixel)
    }

    func removePixel(_ index: Int) -> PixelModel {
        let pixel = pixels.remove(at: index)
        return pixel
    }

    func findPixel(_ value: PixelModel) -> Int {
        return pixels.firstIndex(where: { pixel in pixel.id == value.id }) ?? -1
    }

    func findPixel(_ point: CGPoint) -> Int {
        return pixels.firstIndex(where: { pixel in pixel.getRect().contains(point) }) ?? -1
    }

    func findPixel(_ point: CGPoint) -> PixelModel? {
        return pixels.first(where: { pixel in pixel.getRect().contains(point) })
    }

    func draw(_ context: GraphicsContext) {
        if isVisible {
            pixels.forEach { pixel in pixel.draw(context) }
        }
    }

    /**
     Returns all pixels that are:
     1. Connected to the given point (either by overlapping or overlapping other filled pixels), and
     2. The same color as the "start" pixel
     */
    func getPixelsToFill(_ point: CGPoint) -> [PixelModel] {
        var pixelsToFill: [PixelModel] = []
        if let startPixel: PixelModel = findPixel(point) {
            pixelsToFill.append(startPixel)
            mainLoop: for _ in 0...10 {
                let unfilledPixels: [PixelModel] = pixels.filterOut(pixelsToFill.contains)
                for foundPixel in pixelsToFill {
                    let foundPixelRect = foundPixel.getRect().insetBy(dx: -1, dy: -1)
                    for unfilledPixel in unfilledPixels {
                        if foundPixelRect.intersects(unfilledPixel.getRect())
                            && unfilledPixel.color == startPixel.color {
                            pixelsToFill.append(unfilledPixel)
                            continue mainLoop
                        }
                    }
                }
                break
            }
        }
        return pixelsToFill
    }

    func toggle() {
        isVisible.toggle()
    }
}
