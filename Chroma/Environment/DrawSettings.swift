//
//  CurrentRotation.swift
//  Chroma
//
//  Created by Audrey Serene on 9/12/23.
//

import SwiftUI

enum Tool {
    case draw
    case erase
}

enum ScaleType {
    case even
    case odd
}

class DrawSettings: ObservableObject {
    @Published var rotation = Angle(degrees: 0)
    @Published var tool = Tool.draw
    @Published var shape = SquareShape
    @Published var color = Color.black
    @Published var scaleType = ScaleType.even
    @Published var pixelSize: CGFloat = 5
    @Published var precisionSize: CGFloat = 1
    
    func snapped(_ point: CGPoint) -> CGPoint {
        let x = round(point.x / (getPixelSize() * precisionSize))
        let y = round(point.y / (getPixelSize() * precisionSize))
        return CGPoint(x: x * (getPixelSize() * precisionSize), y: y * (getPixelSize() * precisionSize))
    }
    
    func createPixel(_ point: CGPoint = CGPoint()) -> Pixel {
        return Pixel(
            shape: shape,
            color: color,
            size: getPixelSize(),
            rotation: rotation,
            position: snapped(point)
        )
    }
    
    func getPixelSize() -> CGFloat {
        switch scaleType {
            case .even: return pow(2, pixelSize)
            case .odd: return pow(2, pixelSize + 1) / 3
        }
    }
    
    func getPixelSize() -> CGSize {
        return CGSize(width: getPixelSize(), height: getPixelSize())
    }
    
    func getPixelSize() -> CGPoint {
        return CGPoint(x: getPixelSize(), y: getPixelSize())
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
