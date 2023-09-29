//
//  SvgDocument.swift
//  Chroma
//
//  Created by Audrey Serene on 9/28/23.
//

import SwiftUI
import UniformTypeIdentifiers
import SVG

struct SvgDocument: FileDocument {
    static var readableContentTypes: [UTType] = [.svg]

    private var svg: String?
    private var data: Data? {
        if let svg {
            return svg.data(using: .utf8)
        }
        return nil
    }

    init(_ string: String) {
        self.svg = string
    }
    
    init(_ artboard: ArtboardModel, size: CGSize) {
        self.svg = SVGBuilder(artboard: artboard).toSVG(
            in: CGRect(origin: CGPoint(), size: size),
            style: SVGStyle()
        )
    }
    
    init(_ artboard: ArtboardModel) {
        self.svg = SVGBuilder(artboard: artboard).toSVG(
            in: CGRect(origin: CGPoint(), size: artboard.size),
            style: SVGStyle()
        )
    }

    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            self.svg = String(data: data, encoding: .utf8)
        }
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: data ?? Data())
    }
    
    func getData() -> Data {
        return data ?? Data()
    }
}
