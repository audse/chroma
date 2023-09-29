import SwiftUI

@available(macOS 11.0, *)
public enum SVGFilter {
    case blur(radius: Double)
    case shadow(offset: CGPoint, radius: Double, color: Color)
}

@available(macOS 11.0, *)
extension SVGFilter {
    public func toSVG(in rect: CGRect) -> SVGTag {
        var attrs = SVGAttributeSet()
        switch self {
        case .blur(let radius):
            attrs.add(.init("stdDeviation", .number(radius)))
            return SVGTag(
                name: "feGaussianBlur",
                attributes: attrs,
                singleLine: true
            )
        case .shadow(let offset, let radius, let color):
            attrs.add([
                .init("dx", .number(offset.x)),
                .init("dy", .number(offset.y)),
                .init("stdDeviation", .number(radius)),
                .init("flood-color", .color(color)),
                .init("flood-opacity", .number(color.opacity))
            ])
            return SVGTag(
                name: "feDropShadow",
                attributes: attrs,
                singleLine: true
            )
        }
    }
    
    public func toSVGString(in rect: CGRect) -> String {
        self.toSVG(in: rect).toString()
    }
}
