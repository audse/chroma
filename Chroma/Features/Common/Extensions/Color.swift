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
    
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {
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
    
    var luminance: CGFloat {
        let (r, g, b, _) = components
        return 0.2126 * r + 0.7152 * g + 0.0722 * b
    }

    var isDark: Bool {
        return luminance < 0.5
    }
    
    var hex: String {
        String(
            format: "#%02x%02x%02x%02x",
            Int(components.red * 255),
            Int(components.green * 255),
            Int(components.blue * 255),
            Int(components.opacity * 255)
        )
    }
    
    var contrasting: Color {
        return isDark ? lighten(0.7) : darken(0.7)
    }
    
    func contrast(with other: Color) -> CGFloat {
        return other.luminance - self.luminance
    }
    
    func lighten(_ amount: CGFloat) -> Color {
        let (r, g, b, o) = components
        return Color(red: r + amount, green: g + amount, blue: b + amount, opacity: o)
    }
    
    func darken(_ amount: CGFloat) -> Color {
        let (r, g, b, o) = components
        return Color(red: r - amount, green: g - amount, blue: b - amount, opacity: o)
    }
}
