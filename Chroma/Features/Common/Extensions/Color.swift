//
//  Utils.swift
//  Chroma
//
//  Created by Audrey Serene on 9/15/23.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension Int {
    public var hexString: String {
        String(format: "%02X", self)
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
    static var primaryBackgroundLight: Color {
        return Color(hue: 0.75, saturation: 0.05, brightness: 0.8, opacity: 0.7)
    }
    static var primaryBackgroundDark: Color {
        return Color(hue: 0.75, saturation: 0.1, brightness: 0.3, opacity: 0.7)
    }
    static var almostClear: Color {
        return Color(white: 1, opacity: 0.001)
    }
    
    static public var emerald: Color {
        return Color(red: 5 / 255, green: 150 / 255, blue: 105 / 255, opacity: 1)
    }

    public var components: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0
        #if canImport(UIKit)
        UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &o)
        #elseif canImport(AppKit)
        NSColor(self).usingColorSpace(NSColorSpace.extendedSRGB)?.getRed(&r, green: &g, blue: &b, alpha: &o)
        #endif
        return (r, g, b, o)
    }
    
    public var red: CGFloat {
        return components.red
    }
    
    public var green: CGFloat {
        return components.green
    }
    
    public var blue: CGFloat {
        return components.blue
    }
    
    public var opacity: CGFloat {
        return components.opacity
    }

    public var luminance: CGFloat {
        let (r, g, b, _) = components
        return 0.2126 * r + 0.7152 * g + 0.0722 * b
    }

    public var isDark: Bool {
        return luminance < 0.5
    }
    
    public var isLight: Bool {
        return luminance > 0.5
    }

    public var hex: String {
        let (r, g, b, o) = components
        return "#\(Int(r * 255).hexString)\(Int(g * 255).hexString)\(Int(b * 255).hexString)\(Int(o * 255).hexString)"
    }

    public var contrasting: Color {
        return isDark ? lighten(0.7) : darken(0.7)
    }

    public func contrast(with other: Color) -> CGFloat {
        return other.luminance - self.luminance
    }

    public func lighten(_ amount: CGFloat) -> Color {
        let (r, g, b, o) = components
        return Color(red: r + amount, green: g + amount, blue: b + amount, opacity: o)
    }

    public func darken(_ amount: CGFloat) -> Color {
        let (r, g, b, o) = components
        return Color(red: r - amount, green: g - amount, blue: b - amount, opacity: o)
    }
    
    public func lerp(_ other: Color, by amount: CGFloat = 0.5) -> Color {
        let (r, g, b, o) = components
        let (otherR, otherG, otherB, otherO) = other.components
        return Color(
            red: r.lerp(otherR, by: amount),
            green: g.lerp(otherG, by: amount),
            blue: b.lerp(otherB, by: amount),
            opacity: o.lerp(otherO, by: amount)
        )
    }
}

extension Color: Codable {
    internal enum CodingKeys: CodingKey {
        case red
        case green
        case blue
        case opacity
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.init(
            red: try values.decode(CGFloat.self, forKey: .red),
            green: try values.decode(CGFloat.self, forKey: .green),
            blue: try values.decode(CGFloat.self, forKey: .blue),
            opacity: try values.decode(CGFloat.self, forKey: .opacity)
        )
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(red, forKey: .red)
        try container.encode(green, forKey: .green)
        try container.encode(blue, forKey: .blue)
        try container.encode(opacity, forKey: .opacity)
    }
}
