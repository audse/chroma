import SwiftUI

@available(macOS 11.0, *)
public struct SVGFilterSet {
    public let id = UUID()
    public let components: [SVGFilter]
    
    public init(_ components: [SVGFilter]) {
        self.components = components
    }
}

@available(macOS 11.0, *)
extension SVGFilterSet {
    public func toSVG(in rect: CGRect) -> SVGTag {
        if components.isEmpty {
            return SVGTag(name: "filter")
        }
        let attrs = SVGAttributeSet([
            .id("filter-\( self.id )"),
            .init("filterUnits", .string("userSpaceOnUse")),
            .init("primitiveUnits", .string("userSpaceOnUse")),
            .init("x", .number(0)),
            .init("y", .number(0)),
            .init("width", .number(rect.width)),
            .init("height", .number(rect.height)),
            .init("color-interpolation-filters", .string("sRGB"))
        ])
        return SVGTag(
            name: "filter",
            attributes: attrs,
            content: components.map { $0.toSVG(in: rect) }
        )
    }
}
