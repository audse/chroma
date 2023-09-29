import SwiftUI

@available(macOS 10.15, *)
extension BlendMode {
    // swiftlint:disable:next cyclomatic_complexity
    public init(string: String) {
        switch string {
        case "multiply": self = .multiply
        case "screen": self = .screen
        case "overlay": self = .overlay
        case "darken": self = .darken
        case "lighten": self = .lighten
        case "colorDodge": self = .colorDodge
        case "colorBurn": self = .colorBurn
        case "hardLight": self = .hardLight
        case "softLight": self = .softLight
        case "difference": self = .difference
        case "exclusion": self = .exclusion
        case "hue": self = .hue
        case "saturation": self = .saturation
        case "color": self = .color
        case "luminosity": self = .luminosity
        case "plusDarker": self = .plusDarker
        case "plusLighter": self = .plusLighter
        default: self = .normal
        }
    }
    
    // swiftlint:disable:next cyclomatic_complexity
    public func toString() -> String {
        switch self {
        case .multiply: "multiply"
        case .screen: "screen"
        case .overlay: "overlay"
        case .darken: "darken"
        case .lighten: "lighten"
        case .colorDodge: "color-dodge"
        case .colorBurn: "color-burn"
        case .hardLight: "hard-light"
        case .softLight: "soft-light"
        case .difference: "difference"
        case .exclusion: "exclusion"
        case .hue: "hue"
        case .saturation: "saturation"
        case .color: "color"
        case .luminosity: "luminosity"
        case .plusDarker: "plus-darker"
        case .plusLighter: "plus-lighter"
        default: "normal"
        }
    }
}


@available(macOS 10.15, *)
extension BlendMode: Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.toString())
    }
    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer()
        let string = try value.decode(String.self)
        self.init(string: string)
    }
}
