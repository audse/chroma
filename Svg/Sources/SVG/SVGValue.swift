import SwiftUI

@available(macOS 11.0, *)
public enum SVGValue {
    case number(Double)
    case color(Color)
    case path(Path)
    case string(String)
    case idUrl(String)
    case rotation(Angle, origin: CGPoint)
    case transformation([SVGValue])
}

@available(macOS 11.0, *)
public extension SVGValue {
    func toString() -> String {
        switch self {
        case .number(let value): return "\(value)"
        case .color(let value):
            let hex = value.hex
            return "\( hex[hex.startIndex..<hex.index(of: 7)] )"
        case .path(let value): return value.getSVGPath()
        case .string(let value): return value
        case .idUrl(let id): return "url(#\( id ))"
        case .rotation(let angle, let origin):
            return """
            rotate(\( angle.degrees ), \( origin.x ), \( origin.y ))
            """
        case .transformation(let values): return values.map { $0.toString() }.joined(separator: " ")
        }
    }
}
