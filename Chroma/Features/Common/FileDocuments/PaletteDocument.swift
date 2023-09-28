//
//  PaletteDocument.swift
//  Chroma
//
//  Created by Audrey Serene on 9/27/23.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static let palette = UTType(exportedAs: "com.chroma.palette", conformingTo: .json)
}

public struct PaletteDocument: FileDocument {
    public static var readableContentTypes: [UTType] = [.palette]
    
    public var palette: PaletteModel
    
    public init(_ palette: PaletteModel) {
        self.palette = palette
    }
    
    public init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.palette = try JSONDecoder().decode(PaletteModel.self, from: data)
    }
    
    public func data() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try encoder.encode(palette)
    }
    
    public func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: try data())
    }
}
