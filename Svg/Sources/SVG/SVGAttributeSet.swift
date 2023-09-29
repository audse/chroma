import SwiftUI

@available(macOS 11.0, *)
public struct SVGAttributeSet {
    public var attributes: [SVGAttribute]
    
    public init(_ attributes: [SVGAttribute] = []) {
        self.attributes = attributes
    }
}

@available(macOS 11.0, *)
public extension SVGAttributeSet {
    mutating func add(_ attribute: SVGAttribute) {
        self.attributes.append(attribute)
    }
    
    mutating func add(_ attributes: [SVGAttribute]) {
        self.attributes.append(contentsOf: attributes)
    }
    
    mutating func add(fill color: Color) {
        self.attributes.append(.init("fill", .color(color)))
        if !color.opacity.isApprox(1.0) {
            self.add(.init("opacity", .number(color.opacity)))
        }
    }
    
    mutating func add(blendMode mode: BlendMode) {
        switch mode {
        case .plusDarker, .plusLighter: self.add(.init("mix-blend-mode", .string(mode.toString())))
        default: self.add(.init("blend-mode", .string(mode.toString())))
        }
    }
    
    mutating func add(rotation: SVGValue? = nil) {
        var transformations = [SVGValue]()
        if let rotation {
            transformations.append(rotation)
        }
        self.add(SVGAttribute("transform", .transformation(transformations)))
    }
    
    func toString() -> String {
        self.attributes.map { $0.toString() }.joined(separator: " ")
    }
}
