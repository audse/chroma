//
//  PngDocument.swift
//  Chroma
//
//  Created by Audrey Serene on 9/19/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct PngDocument: FileDocument {
    static var readableContentTypes: [UTType] = [.png]

    private var data: Data?

    init(_ cgImage: CGImage?) {
        if let cgImage = cgImage {
            let image = NSImage(cgImage: cgImage, size: .init(width: cgImage.width, height: cgImage.height))
            guard let representation = image.tiffRepresentation else { return }
            let imageRepresentation = NSBitmapImageRep(data: representation)
            self.data = imageRepresentation?.representation(using: .png, properties: [:])
        }
    }

    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            self.data = data
        }
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: data ?? Data())
    }
}
