import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

@available(macOS 10.15, *)
public extension Color {
    init(hue: CGFloat) {
        self.init(hue: hue, saturation: 1, brightness: 1)
    }
    init(saturation: CGFloat) {
        self.init(hue: 0, saturation: saturation, brightness: 1)
    }
    init(brightness: CGFloat) {
        self.init(hue: 0, saturation: 1, brightness: brightness)
    }
}

@available(macOS 10.15, *)
public extension Color {
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
    static var emerald: Color {
        return Color(red: 5 / 255, green: 150 / 255, blue: 105 / 255, opacity: 1)
    }
    
    @available(macOS 11.0, *)
    var almostClear: Color {
        return self.opacity(to: 0.001)
    }

    @available(macOS 11.0, *)
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
    
    @available(macOS 11.0, *)
    var hsb: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat) {
        let (r, g, b, _) = components
      
        let cmax = max(r, max(g, b))
        let cmin = min(r, min(g, b))
        let diff = cmax - cmin
        
        let hue: CGFloat = switch cmax {
        case cmin: 0.0
        case r: (60 * ((g - b) / diff) + 360).truncatingRemainder(dividingBy: 360)
        case g: (60 * ((b - r) / diff) + 120).truncatingRemainder(dividingBy: 360)
        case b: (60 * ((r - g) / diff) + 240).truncatingRemainder(dividingBy: 360)
        default: -1.0
        }
        let saturation: CGFloat = switch cmax {
        case 0: 0
        default: (diff / cmax)
        }
        let brightness: CGFloat = cmax
        return (hue / 360, saturation, brightness)
    }
    
    @available(macOS 11.0, *)
    var red: CGFloat {
        return components.red
    }
    
    @available(macOS 11.0, *)
    var green: CGFloat {
        return components.green
    }
    
    @available(macOS 11.0, *)
    var blue: CGFloat {
        return components.blue
    }
    
    @available(macOS 11.0, *)
    var opacity: CGFloat {
        return components.opacity
    }
    
    @available(macOS 11.0, *)
    var luminance: CGFloat {
        let (r, g, b, _) = components
        return 0.2126 * r + 0.7152 * g + 0.0722 * b
    }
    
    @available(macOS 11.0, *)
    var isDark: Bool {
        return luminance < 0.5
    }
    
    @available(macOS 11.0, *)
    var isLight: Bool {
        return luminance > 0.5
    }
    
    @available(macOS 11.0, *)
    var hex: String {
        let (r, g, b, o) = components
        return "#\(Int(r * 255).hexString)\(Int(g * 255).hexString)\(Int(b * 255).hexString)\(Int(o * 255).hexString)"
    }
    
    @available(macOS 11.0, *)
    var contrasting: Color {
        return isDark ? lighten(0.7) : darken(0.7)
    }
    
    @available(macOS 11.0, *)
    func contrast(with other: Color) -> CGFloat {
        return abs(other.luminance - self.luminance)
    }
    
    @available(macOS 11.0, *)
    func lighten(_ amount: CGFloat) -> Color {
        let (r, g, b, o) = components
        return Color(red: r + amount, green: g + amount, blue: b + amount, opacity: o)
    }
    
    @available(macOS 11.0, *)
    func darken(_ amount: CGFloat) -> Color {
        let (r, g, b, o) = components
        return Color(red: r - amount, green: g - amount, blue: b - amount, opacity: o)
    }
    
    @available(macOS 11.0, *)
    func hue(_ newValue: CGFloat) -> Color {
        let (_, s, b) = hsb, o = opacity
        return Color(hue: newValue, saturation: s, brightness: b, opacity: o)
    }
    
    @available(macOS 11.0, *)
    func saturation(_ newValue: CGFloat) -> Color {
        let (h, _, b) = hsb, o = opacity
        return Color(hue: h, saturation: newValue, brightness: b, opacity: o)
    }
    
    @available(macOS 11.0, *)
    func brightness(_ newValue: CGFloat) -> Color {
        let (h, s, _) = hsb, o = opacity
        return Color(hue: h, saturation: s, brightness: newValue, opacity: o)
    }
    
    @available(macOS 11.0, *)
    func opacity(to newValue: CGFloat) -> Color {
        let (h, s, b) = hsb
        return Color(hue: h, saturation: s, brightness: b, opacity: newValue)
    }
}

@available(macOS 11.0, *)
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

@available(macOS 11.0, *)
extension Color: IsApprox {
    public func isApprox(
        _ other: Color,
        epsilon: Color = Color(red: 0.001, green: 0.001, blue: 0.001, opacity: 0.001)
    ) -> Bool {
        let (r, g, b, o) = self.components
        let (otherR, otherG, otherB, otherO) = other.components
        let (epR, epG, epB, epO) = epsilon.components
        return [
            (r, otherR, epR),
            (g, otherG, epG),
            (b, otherB, epB),
            (o, otherO, epO)
        ].allSatisfy { (this, other, epsilon) in
            this.isApprox(other, epsilon: epsilon)
        }
    }
}

@available(macOS 11.0, *)
extension Color: Lerp {
    public func lerp(_ other: Color, by amount: CGFloat = 0.5) -> Color {
        let (r, g, b, o) = self.components
        let (otherR, otherG, otherB, otherO) = other.components
        return Color(
            red: r.lerp(otherR, by: amount).clamp(low: 0, high: 1),
            green: g.lerp(otherG, by: amount).clamp(low: 0, high: 1),
            blue: b.lerp(otherB, by: amount).clamp(low: 0, high: 1),
            opacity: o.lerp(otherO, by: amount).clamp(low: 0, high: 1)
        )
    }
}

@available(macOS 11.0, *)
extension Color: JSONTestable {}
