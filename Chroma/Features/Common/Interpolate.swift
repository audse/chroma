//
//  Interpolate.swift
//  Chroma
//
//  Created by Audrey Serene on 9/27/23.
//

import Foundation

public struct Interpolate {
    let curve: (start: (Double, Double), end: (Double, Double))
    
    static let linear = Interpolate(0, 0, 1, 1)
    static let easeInOut = Interpolate(0.42, 0.0, 0.58, 1.0)
    static let easeIn = Interpolate(0.42, 0, 1, 1)
    static let easeOut = Interpolate(0, 0, 0.58, 1)
    static let fastInOut = Interpolate(0, 0.42, 1, 0.58)
    
    init(_ startX: Double, _ startY: Double, _ endX: Double, _ endY: Double) {
        self.curve = ((startX, startY), (endX, endY))
    }
    
    public func scaled(by amount: Double) -> Interpolate {
        return Interpolate(
            curve.start.0 * amount,
            curve.start.1 * amount,
            (curve.end.0 - 1.0) * amount + 1.0,
            (curve.end.1 - 1.0) * amount + 1.0
        )
    }
    
    public func value(at weight: Double) -> Double {
        let (start, end) = curve
        return Interpolate.cubic(x1: start.0, x2: end.0, y1: start.1, y2: end.1, weight: weight)
    }
    
    // swiftlint:disable identifier_name
    static internal func cubicBezier(t: Double, p1: Double, p2: Double) -> Double {
        return (
          3 * (1 - t) * (1 - t) * t * p1 +
          3 * (1 - t) * t * t * p2 +
          t * t * t
        )
    }
    
    public static func cubic(
        x1: Double,
        x2: Double,
        y1: Double,
        y2: Double,
        weight: Double
    ) -> Double {
        let weight = Double(CGFloat(weight).clamp(low: 0, high: 1))
        
        // Lower value will give more precise result
        let tolerance = 0.001

        // Start with the full 0...1 range
        var start: Double = 0
        var finish: Double = 1
        var t: Double = (start + finish) / 2

        // Get X-axis value for the middle point
        var bezierX = Interpolate.cubicBezier(t: t, p1: x1, p2: x2)

        // Repeat until the desired X value found
        while abs(weight - bezierX) > tolerance {
            if weight > bezierX {
                start = t
            } else {
                finish = t
            }
            t = (start + finish) / 2
              bezierX = Interpolate.cubicBezier(t: t, p1: x1, p2: x2)
          }

        // Return Y-axis value for the last t value
        return Interpolate.cubicBezier(t: t, p1: y1, p2: y2)
    }
    // swiftlint:enable identifier_name
}
