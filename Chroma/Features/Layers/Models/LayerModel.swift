//
//  LayerModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI
import Combine

public final class LayerModel: ObservableObject, Identifiable {
    public let id: UUID
    @Published public var name: String
    
    // swiftlint:disable:next identifier_name
    internal var _pixelCancellables: [AnyCancellable] = []
    @Published public var pixels: [LayerPixelModel] {
        didSet { self._pixelCancellables = self.pixels.map { pixel in
            pixel.pixel.objectWillChange.sink { _ in self.objectWillChange.send() }
        } }
    }
    
    @Published public var isVisible: Bool
    @Published public var isLocked: Bool
    
    init(
        id: UUID = UUID(),
        name: String = "Layer",
        pixels: [LayerPixelModel] = [],
        isVisible: Bool = true,
        isLocked: Bool = false
    ) {
        self.id = id
        self.name = name
        self.pixels = pixels
        self.isVisible = isVisible
        self.isLocked = isLocked
    }
}

extension LayerModel: Equatable {
    public static func == (lhs: LayerModel, rhs: LayerModel) -> Bool {
        return lhs.id == rhs.id
    }
}

extension LayerModel: Codable {
    internal enum CodingKeys: CodingKey {
        case id
        case name
        case pixels
        case isVisible
    }
    
    public convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.init(
            id: try values.decode(UUID.self, forKey: .id),
            name: try values.decode(String.self, forKey: .name),
            pixels: try values.decode([LayerPixelModel].self, forKey: .pixels),
            isVisible: try values.decode(Bool.self, forKey: .isVisible)
        )
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(pixels, forKey: .pixels)
        try container.encode(isVisible, forKey: .isVisible)
    }
}

extension LayerModel {
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
    
    func getSelectionPath(_ history: History) -> Path {
        return Path().union(history.getCurrentSelection().map { pixel in pixel.pixel.path() })
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
}
