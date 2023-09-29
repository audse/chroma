import SwiftUI

@available(macOS 11.0, *)
extension Shape {
    public func toSVG(in rect: CGRect, attributes: inout SVGAttributeSet) -> SVGTag {
        return self.path(in: rect).toSVG(in: rect, attributes: &attributes)
    }
    
    public func toSVGString(in rect: CGRect, attributes: inout SVGAttributeSet) -> String {
        return self.toSVG(in: rect, attributes: &attributes).toString()
    }
}
