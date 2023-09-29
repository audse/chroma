import SwiftUI

@available(macOS 11.0, *)
public struct SVGLayer {
    public let id = UUID()
    public let components: [SVGTag]
    public let clipComponents: [SVGTag]
    public let filters: SVGFilterSet?
    public let attributes: SVGAttributeSet?
    
    public init(
        _ components: [SVGTag],
        clip: [SVGTag], 
        filters: SVGFilterSet? = nil,
        attributes: SVGAttributeSet? = nil
    ) {
        self.components = components
        self.clipComponents = clip
        self.filters = filters
        self.attributes = attributes
    }
}

@available(macOS 11.0, *)
extension SVGLayer {
    
    var hasFilters: Bool {
        if let filters { return !filters.components.isEmpty }
        return false
    }
    
    var hasMask: Bool {
        !clipComponents.isEmpty
    }
    
    var hasDefs: Bool {
        hasFilters || hasMask
    }
    
    public func maskToSVG(in rect: CGRect) -> SVGTag {
        var content: [SVGTag] = [.init(
            from: Rectangle(),
            in: rect,
            attributes: SVGAttributeSet([.fill(.white)])
        )]
        content.append(contentsOf: clipComponents)
        return SVGTag(
            name: "mask",
            attributes: SVGAttributeSet([.id("mask-\( self.id )")]),
            content: content
        )
    }
    
    public func toSVG(in rect: CGRect) -> (SVGTag, defs: [SVGTag]) {
        var maskGroupTag = SVGTag(name: "g", content: [])
        var filterGroupTag = SVGTag(name: "g", content: [])
        var defs: [SVGTag] = []
        var content: SVGTag
        
        if hasFilters, let filters {
            let filterTag = filters.toSVG(in: rect)
            filterGroupTag.add(attribute: .init("filter", .idUrl("filter-\( filters.id )")))
            defs.append(filterTag)
        }
        
        if hasMask {
            let maskTag = maskToSVG(in: rect)
            maskGroupTag.add(attribute: .init("mask", .idUrl("mask-\( self.id )")))
            defs.append(maskTag)
        }
        
        if hasFilters && hasMask {
            maskGroupTag.content = components
            filterGroupTag.add(tag: maskGroupTag)
            content = filterGroupTag
        } else if hasFilters {
            filterGroupTag.content = components
            content = filterGroupTag
        } else if hasMask {
            maskGroupTag.content = components
            content = maskGroupTag
        } else {
            content = SVGTag(name: "g", content: components)
        }
        
        if let attributes {
            content.attributes.add(attributes.attributes)
        }
        
        return (content, defs: defs)
    }
}
