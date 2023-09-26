//
//  CurrentRotation.swift
//  Chroma
//
//  Created by Audrey Serene on 9/12/23.
//

import SwiftUI
import Extensions

class DrawSettings: ObservableObject {
    @Published var rotation = Angle(degrees: 0)
    @Published private(set) var tool: Tool = .draw(.positive)
    @Published var shape = SquareShape
    @Published var color = Color.black
    @Published var scaleType = ScaleType.even
    @Published var pixelSize: CGFloat = 5
    @Published var precisionSize: CGFloat = 1

    /**
     Used for multi-click actions such as drawing lines, rectangles, etc.
     */
    @Published var multiClickState: [CGPoint] = []

    func tool(_ value: Tool) -> DrawSettings {
        self.tool = value
        return self
    }

    func setTool(_ value: Tool) {
        self.tool = value
        self.multiClickState.removeAll()
    }
    
    func snapped(_ point: CGPoint) -> CGPoint {
        let size: CGSize = getPixelSize()
        let x = floor(point.x / (size.width * precisionSize))
        let y = floor(point.y / (size.height * precisionSize))
        return CGPoint(x: x * (size.width * precisionSize), y: y * (size.height * precisionSize))
    }
    
    func snapped(_ size: CGSize) -> CGSize {
        return CGSize(snapped(CGPoint(size)))
    }

    func getPixelSize() -> CGFloat {
        switch scaleType {
        case .even: 
            let base = pow(2, floor(pixelSize))
            let oneUp = pow(2, floor(pixelSize) + 1)
            if (pixelSize - floor(pixelSize)).isApprox(0.5) {
                return base + (oneUp - base) / 2
            }
            return base
        case .odd:
            let oneUp = pow(2, floor(pixelSize) + 1)
            let twoUp = pow(2, floor(pixelSize) + 2)
            if (pixelSize - floor(pixelSize)).isApprox(0.5) {
                return (oneUp + (twoUp - oneUp) / 2) * (2/3)
            }
            return oneUp * (2/3)
        }
    }

    func getPixelSize() -> CGSize {
        let ratio = shape.ratio(rotation)
        let number: CGFloat = getPixelSize()
        return CGSize(number) * CGSize(ratio.x, ratio.y)
    }

    func getPixelSize() -> CGPoint {
        let size: CGSize = getPixelSize()
        return CGPoint(size)
    }
    
    func createPixel(_ point: CGPoint = CGPoint()) -> PixelModel {
        return PixelModel(
            shape: self.shape,
            color: self.color,
            size: self.getPixelSize(),
            rotation: self.rotation,
            position: self.snapped(point)
        )
    }
    
    func createPixelPath(_ points: [CGPoint]) -> [PixelModel] {
        var pixelsToAdd = [PixelModel]()
        for point in points {
            // swiftlint:disable:next for_where
            if pixelsToAdd.first(where: { pixel in pixel.hasPoint(point) }) == nil {
                pixelsToAdd.append(createPixel(point))
            }
        }
        return pixelsToAdd
    }

    func createPixelLine(_ pointA: CGPoint, _ pointB: CGPoint) -> [PixelModel] {
        var pixels: [PixelModel] = []
        let a = snapped(pointA)
        let b = snapped(pointB)
        let increment: CGFloat = getPixelSize()
        var position = a
        pixels.append(createPixel(position))
        while abs(position.distance(to: b)) > increment / 2 {
            position = position.moveToward(b, by: increment)
            pixels.append(createPixel(position))
        }
        return pixels
    }

    func createPixelRect(_ pointA: CGPoint, _ pointB: CGPoint) -> [PixelModel] {
        var pixels: [PixelModel] = []
        let a = snapped(pointA), b = snapped(pointB)
        let startX = min(a.x, b.x), endX = max(a.x, b.x), startY = min(a.y, b.y), endY = max(a.y, b.y)
        let increment: CGSize = getPixelSize()
        var xPos: CGFloat = startX
        while xPos < endX + increment.width {
            var yPos: CGFloat = startY
            while yPos < endY + increment.height {
                pixels.append(createPixel(CGPoint(xPos, yPos)))
                yPos += increment.height
            }
            xPos += increment.width
        }
        return pixels
    }
}

private struct DrawSettingsKey: EnvironmentKey {
    static var defaultValue = DrawSettings()
}

private struct RotationKey: EnvironmentKey {
    static var defaultValue = Angle()
}

extension EnvironmentValues {
    var drawSettings: DrawSettings {
        get { self[DrawSettingsKey.self] }
        set (newValue) { self[DrawSettingsKey.self] = newValue }
    }
}
