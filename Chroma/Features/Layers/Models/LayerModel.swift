//
//  LayerModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI
import Combine

class LayerModel: ObservableObject, Identifiable, Equatable {
    private(set) var id = UUID()
    @Published private(set) var name = "Layer"
    @Published var pixels: [LayerPixelModel] = [] {
        didSet { self._pixelCancellables = self.pixels.map { pixel in
            pixel.pixel.objectWillChange.sink { _ in self.objectWillChange.send() }
        } }
    }
    @Published private(set) var isVisible: Bool = true

    // swiftlint:disable:next identifier_name
    internal var _pixelCancellables: [AnyCancellable] = []
    
    @Published private var _selectedPixels: [LayerPixelModel] = []
    var selectedPixels: [LayerPixelModel] {
        get { return _selectedPixels.intersection(pixels) }
        set { _selectedPixels = newValue.intersection(pixels) }
    }

    init(
        id: UUID = UUID(),
        name: String = "Layer",
        pixels: [LayerPixelModel] = [],
        isVisible: Bool = true
    ) {
        self.id = id
        self.name = name
        self.pixels = pixels
        self.isVisible = isVisible
    }

    func addPixel(_ pixel: LayerPixelModel) {
        pixels.append(pixel)
    }
    
    func insertPixel(_ pixel: LayerPixelModel, at index: Int) {
        pixels.insert(pixel, at: index)
    }
    
    func insertPixels(_ pixelsToInsert: [LayerPixelModel], at index: Int) {
        pixels.insert(contentsOf: pixelsToInsert, at: index)
    }
    
    func removePixel(_ value: LayerPixelModel) {
        pixels = pixels.filterOut(value)
    }

    func removePixel(_ index: Int) -> LayerPixelModel {
        let pixel = pixels.remove(at: index)
        return pixel
    }

    func findPixel(_ value: LayerPixelModel) -> Int? {
        return pixels.firstIndex(of: value)
    }
    
    func findPixel(_ point: CGPoint) -> (Int, LayerPixelModel)? {
        if let index = pixels.firstIndex(where: { pixel in pixel.pixel.getRect().contains(point) }) {
            return (index, pixels[index])
        }
        return nil
    }

    func draw(_ context: inout GraphicsContext) {
        if isVisible {
            pixels.reversed().forEach { pixel in pixel.draw(&context) }
        }
    }
    
    func getSelectionPath() -> Path {
        return Path().union(selectedPixels.map { pixel in pixel.pixel.path() })
    }

    /**
     Returns all pixels that are:
     1. Connected to the given point (either by overlapping or overlapping other filled pixels), and
     2. The same color as the "start" pixel
     */
    func getPixelsToFill(_ point: CGPoint) -> [LayerPixelModel] {
        var pixelsToFill: [LayerPixelModel] = []
        if let (_, startPixel) = findPixel(point) {
            pixelsToFill.append(startPixel)
            mainLoop: for _ in 0...10 {
                let unfilledPixels: [LayerPixelModel] = pixels.filterOut(pixelsToFill.contains)
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
    
    func getSelectedPixels(in shape: Path) -> [LayerPixelModel] {
        return pixels.filter { pixel in pixel.pixel.isSelected(shape) }
    }

    func toggle() {
        isVisible.toggle()
    }
    
    static func == (lhs: LayerModel, rhs: LayerModel) -> Bool {
        return lhs.id == rhs.id
    }
}
