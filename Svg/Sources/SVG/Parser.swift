import SwiftUI

protocol ParseSVG {
    associatedtype SVGComponent
    func parse() -> SVGComponent
}

@available(macOS 11.0, *)
struct SVGAttributeParser {
    let name: String
    let value: String
}

@available(macOS 11.0, *)
struct SVGTagParser {
    let name: String
    let attributes: [String: String]
}

class SVGParserDelegate: NSObject, XMLParserDelegate {
    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String: String] = [:]
    ) {
        print(elementName)
        for (key, value) in attributeDict {
            print("\t", key, ":", value)
        }
    }
}

func parseSVG(_ svgString: String) {
    if let data = svgString.data(using: .utf8) {
        let parser = XMLParser(data: data)
        let delegate = SVGParserDelegate()
        parser.delegate = delegate
        parser.parse()
    }
}
