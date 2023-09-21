//
//  CurrentRotation.swift
//  Chroma
//
//  Created by Audrey Serene on 9/12/23.
//

import SwiftUI

class DrawSettings: ObservableObject {
    @Published var rotation = Angle(degrees: 0)
    @Published var tool: Tool = .draw
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
    
    func snapped(_ point: CGPoint) -> CGPoint {
        let x = round(point.x / (getPixelSize() * precisionSize))
        let y = round(point.y / (getPixelSize() * precisionSize))
        return CGPoint(x: x * (getPixelSize() * precisionSize), y: y * (getPixelSize() * precisionSize))
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
    
    func getPixelSize() -> CGFloat {
        switch scaleType {
            case .even: return pow(2, pixelSize)
            case .odd: return pow(2, pixelSize + 1) / 3
        }
    }
    
    func getPixelSize() -> CGSize {
        return CGSize(getPixelSize())
    }
    
    func getPixelSize() -> CGPoint {
        return CGPoint(getPixelSize())
    }
    
    func createPixelsBetweenPoints(_ pointA: CGPoint, _ pointB: CGPoint) -> [PixelModel] {
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
