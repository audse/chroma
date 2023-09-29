import SwiftUI

@available(macOS 11.0, *)
public struct SVGAttribute {
    public let name: String
    public let value: SVGValue
    
    public init(_ name: String, _ value: SVGValue) {
        self.name = name
        self.value = value
    }
}

@available(macOS 11.0, *)
public extension SVGAttribute {
    
    static func fill(_ color: Color) -> Self {
        Self("fill", .color(color))
    }
    
    static func id(_ id: String) -> Self {
        Self("id", .string(id))
    }
    
    func toString() -> String {
        "\( name )=\"\( value.toString() )\""
    }
}
