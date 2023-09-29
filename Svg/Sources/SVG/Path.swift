import SwiftUI

@available(macOS 11.0, *)
public extension Path {
    init?(svg string: String) {
        var path = Path()
        var svg = string
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
extension Path {
    public func toSVG(in rect: CGRect, attributes: inout SVGAttributeSet) -> SVGTag {
        attributes.add(.init("d", .path(self.path(in: rect))))
        return SVGTag(
            name: "path",
            attributes: attributes,
            singleLine: true
        )
    }
    
    public func toSVGString(in rect: CGRect, attributes: inout SVGAttributeSet) -> String {
        return self.toSVG(in: rect, attributes: &attributes).toString()
    }
}
