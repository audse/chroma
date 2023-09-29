import SwiftUI

public enum SVGPathCommand {
    case line([Double])
    case move([Double])
    case curve([Double])
    case quadCurve([Double])
    case closeSubpath
    case none
}

@available(macOS 10.15, *)
public extension SVGPathCommand {
    mutating func add(_ component: Double) {
        switch self {
        case .line(var parts):
            parts.append(component)
            self = .line(parts)
        case .move(var parts):
            parts.append(component)
            self = .move(parts)
        case .curve(var parts):
            parts.append(component)
            self = .curve(parts)
        case .quadCurve(var parts):
            parts.append(component)
            self = .quadCurve(parts)
        default: return
        }
    }
    
    func execute(_ path: inout Path) {
        switch self {
        case .closeSubpath: path.closeSubpath()
        case .curve(let p): path.addCurve(
            to: CGPoint(p[4], p[5]),
            control1: CGPoint(p[0], p[1]),
            control2: CGPoint(p[2], p[3])
        )
        case .line(let p): path.addLine(to: CGPoint(p[0], p[1]))
        case .move(let p): path.move(to: CGPoint(p[0], p[1]))
        case .quadCurve(let p): path.addQuadCurve(
            to: CGPoint(p[2], p[3]),
            control: CGPoint(p[0], p[1])
        )
        case .none: return
        }
    }
}
