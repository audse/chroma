import SwiftUI
import Extensions

@available(macOS 11.0, *)
public enum SVGUnit: String {
    case pixels
    case percent
    case none
    
}

@available(macOS 11.0, *)
public enum SVGValue {
    case double(Double)
    case int(Int)
    case color(Color)
    case path(Path)
    case string(String)
    case rotation(Angle, origin: CGPoint)
}

@available(macOS 11.0, *)
public struct SVGAttribute {
    public let name: String
    public let value: SVGValue
    public var unit: SVGUnit = .none
    
    public init(_ name: String, _ value: SVGValue, unit: SVGUnit = .none) {
        self.name = name
        self.value = value
        self.unit = unit
    }
}

@available(macOS 11.0, *)
public struct SVGStyle {
    public let fill: Color?
    public let opacity: CGFloat?
    public let rotation: Angle?
    public let blendMode: BlendMode?
    
    public init(fill: Color? = nil, opacity: CGFloat? = nil, rotation: Angle? = nil, blendMode: BlendMode? = nil) {
        self.fill = fill
        self.opacity = opacity
        self.rotation = rotation
        self.blendMode = blendMode
    }
}

public enum SVGPathCommand {
    case line([Double])
    case move([Double])
    case curve([Double])
    case quadCurve([Double])
    case closeSubpath
    case none
}

@available(macOS 11.0, *)
public extension SVGUnit {
    func toString() -> String {
        switch self {
        case .pixels: return "px"
        case .percent: return "percent"
        case .none: return ""
        }
    }
}

@available(macOS 11.0, *)
public extension SVGValue {
    func toString() -> String {
        switch self {
        case .double(let value): return "\(value)"
        case .int(let value): return "\(value)"
        case .color(let value):
            let hex = value.hex
            return "\( hex[hex.startIndex..<hex.index(of: 7)] )"
        case .path(let value): return value.getSVGPath()
        case .string(let value): return value
        case .rotation(let angle, let origin):
            return """
            rotate(\( angle.degrees ), \( origin.x ), \( origin.y ))
            """
        }
    }
}

@available(macOS 11.0, *)
public extension SVGAttribute {
    func toString() -> String {
        "\( name )=\"\( value.toString() )\( unit.toString() )\""
    }
}

@available(macOS 11.0, *)
public extension SVGStyle {
    func attributes(in rect: CGRect) -> [SVGAttribute] {
        var attrs = [SVGAttribute]()
        if let fill {
            attrs.append(.init("fill", .color(fill)))
            if !fill.opacity.isApprox(1) && opacity == nil {
                attrs.append(.init("opacity", .double(fill.opacity)))
            }
        }
        if let opacity {
            attrs.append(.init("opacity", .double(opacity)))
        }
        if let rotation {
            attrs.append(.init("transform", .rotation(rotation, origin: rect.center)))
        }
        if let blendMode {
            attrs.append(.init(
                [.plusDarker, .plusLighter].contains(blendMode) ? "mix-blend-mode" : "blend-mode",
                .string(blendMode.toString())
            ))
        }
        return attrs
    }
    
    func toString(in rect: CGRect, _ attributes: [SVGAttribute] = []) -> String {
        var attrs = self.attributes(in: rect)
        attrs.append(contentsOf: attributes)
        return attrs.map { attr in attr.toString() }.joined(separator: " ")
    }
    
    func makeTag(_ name: String, in rect: CGRect, _ attributes: [SVGAttribute]) -> String {
        return "<\(name) \( self.toString(in: rect, attributes) ) />"
    }
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

@available(macOS 11.0, *)
public protocol ToSVG {
    func toSVG(in rect: CGRect, style: SVGStyle) -> String
}

@available(macOS 11.0, *)
public extension Path {
    init?(svg string: String) {
        var path = Path()
        var svg = string
//        if svg.starts(with: "<path") {
//            svg.trimStart("<path")
//        }
//        if svg.hasSuffix("/>") {
//            svg.trimEnd("/>")
//        }
        svg = svg.trimmingCharacters(in: .whitespaces)
        var commands: [SVGPathCommand] = []
        var command: SVGPathCommand = .none
        for string in svg.split(separator: " ") {
            if ["L", "M", "C", "Q", "Z"].contains(string.uppercased()) {
                commands.append(command)
            }
            switch string.uppercased() {
            case "L": command = .line([])
            case "M": command = .move([])
            case "C": command = .curve([])
            case "Q": command = .quadCurve([])
            case "Z": command = .closeSubpath
            default:
                if let component = Double(string) {
                    command.add(component)
                }
            }
        }
        commands.append(command)
        if commands.isEmpty { return nil }
        commands.forEach { command in command.execute(&path) }
        self = path
    }
    
    func getSVGPath() -> String {
        var string = ""
        self.forEach { element in
            switch element {
            case .line(to: let point): string.append("L \( point.x ) \( point.y )")
            case .move(to: let point): string.append("M \( point.x ) \( point.y )")
            case .curve(to: let toPoint, control1: let c1Point, control2: let c2Point):
                string.append("C \( c1Point.x ) \( c1Point.y )")
                string.append(" \( c2Point.x ) \( c2Point.y )")
                string.append(" \( toPoint.x ) \( toPoint.y )")
            case .quadCurve(to: let toPoint, control: let controlPoint):
                string.append("Q \( controlPoint.x ) \( controlPoint.y )")
                string.append(" \( toPoint.x ) \( toPoint.y )")
            case .closeSubpath: string.append("Z")
            }
            string.append(" ")
        }
        return string.trimmingCharacters(in: .whitespaces)
    }
}

@available(macOS 11.0, *)
extension Path: ToSVG {
    public func toSVG(in rect: CGRect, style: SVGStyle) -> String {
        return style.makeTag("path", in: rect, [
            .init("d", .path(self.path(in: rect)))
        ])
    }
}

@available(macOS 11.0, *)
extension Shape {
    public func toSVG(in rect: CGRect, style: SVGStyle) -> String {
        return self.path(in: rect).toSVG(in: rect, style: style)
    }
}

@available(macOS 11.0, *)
public struct SVGComponent {
    public let shape: any Shape
    public let rect: CGRect
    public let style: SVGStyle
    
    public init(_ shape: any Shape, in rect: CGRect, style: SVGStyle) {
        self.shape = shape
        self.rect = rect
        self.style = style
    }
}

@available(macOS 11.0, *)
public struct SVGLayer {
    public let id = UUID()
    public let components: [SVGComponent]
    public let clipComponents: [SVGComponent]
    public let style: SVGStyle?
    
    public init(_ components: [SVGComponent], clip: [SVGComponent], style: SVGStyle? = nil) {
        self.components = components
        self.clipComponents = clip
        self.style = style
    }
}

@available(macOS 11.0, *)
public struct SVGBuilder {
    public var layers: [SVGLayer]
    
    public init(_ layers: [SVGLayer]) {
        self.layers = layers
    }
}

@available(macOS 11.0, *)
extension SVGComponent {
    public func toSVG() -> String {
        return self.shape.toSVG(in: self.rect, style: self.style)
    }
}

@available(macOS 11.0, *)
extension SVGLayer: ToSVG {
    public func toSVG(in rect: CGRect, style: SVGStyle) -> String {
        let components = self.components.map { $0.toSVG() }
        let clipComponents = self.clipComponents.map { $0.toSVG() }
        let mask = clipComponents.isEmpty ? "" : """
            <mask id="mask-\( self.id )">
                \( Rectangle().toSVG(in: rect, style: SVGStyle(fill: .white)) )
                \( clipComponents.joined(separator: "\n") )
            </mask>
            """
        var attrs = [SVGAttribute]()
        if !clipComponents.isEmpty {
            attrs.append(.init("mask", .string("url(#mask-\( self.id ))")))
        }
        return """
        <defs>
            \( mask )
        </defs>
        <g \( (self.style ?? SVGStyle()).toString(in: rect, attrs) )>
            \( components.joined(separator: "\n") )
        </g>
        """
    }
}

@available(macOS 11.0, *)
extension SVGBuilder: ToSVG {
    public func toSVG(in rect: CGRect, style: SVGStyle) -> String {
        let layers = self.layers.map { $0.toSVG(in: rect, style: style) }
        return """
        <svg viewBox="0 0 \( rect.width ) \( rect.height )" version="1.1" xmlns="http://www.w3.org/2000/svg">
            \( layers.joined(separator: "\n") )
        </svg>
        """
    }
}
