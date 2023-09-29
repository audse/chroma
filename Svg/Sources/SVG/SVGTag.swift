import SwiftUI


@available(macOS 11.0, *)
public struct SVGTag {
    public let name: String
    public var attributes: SVGAttributeSet
    public var content: [SVGTag]
    public let singleLine: Bool
    
    public init(
        name: String,
        attributes: SVGAttributeSet = SVGAttributeSet(),
        content: [SVGTag] = [],
        singleLine: Bool = false
    ) {
        self.name = name
        self.attributes = attributes
        self.content = content
        self.singleLine = singleLine
    }
}

@available(macOS 11.0, *)
public extension SVGTag {
    
    init(from shape: any Shape, in rect: CGRect, attributes: SVGAttributeSet) {
        var attrs = attributes
        self = shape.toSVG(in: rect, attributes: &attrs)
    }
    
    mutating func add(attribute: SVGAttribute) {
        self.attributes.add(attribute)
    }
    
    mutating func add(tag: SVGTag) {
        self.content.append(tag)
    }
    
    func toString() -> String {
        if singleLine && content.isEmpty {
            return """
            <\( self.name ) \( self.attributes.toString() ) />
            """
        }
        return """
        <\( self.name ) \( self.attributes.toString() )>
            \( self.content.map { $0.toString() }.joined(separator: " ") )
        </\( self.name )>
        """
    }
}
