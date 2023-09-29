import SwiftUI
import Extensions

@available(macOS 11.0, *)
public struct SVG {
    public var backgroundColor: Color?
    public var layers: [SVGLayer]
    
    public init(_ backgroundColor: Color?, _ layers: [SVGLayer]) {
        self.backgroundColor = backgroundColor
        self.layers = layers
    }
}

@available(macOS 11.0, *)
extension SVG {
    public func toSVG(in rect: CGRect) -> SVGTag {
        var layers = [SVGTag]()
        var defs = [SVGTag]()
        if let backgroundColor {
            var attributes = SVGAttributeSet()
            attributes.add(fill: backgroundColor)
            let backgroundTag = SVGTag(
                from: Path(rect),
                in: rect,
                attributes: attributes
            )
            layers.append(backgroundTag)
        }
        for layer in self.layers {
            let (layerTag, defTags) = layer.toSVG(in: rect)
            layers.append(layerTag)
            defs.append(contentsOf: defTags)
        }
        layers.insert(SVGTag(name: "defs", content: defs), at: 0)
        return SVGTag(
            name: "svg",
            attributes: SVGAttributeSet([
                .init("viewBox", .string("0 0 \( rect.width ) \( rect.height )")),
                .init("version", .string("1.1")),
                .init("xmlns", .string("http://www.w3.org/2000/svg"))
            ]),
            content: layers
        )
    }
    public func toSVGString(in rect: CGRect) -> String {
        return toSVG(in: rect).toString()
    }
}
