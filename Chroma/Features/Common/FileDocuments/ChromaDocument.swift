//
//  ChromaDocument.swift
//  Chroma
//
//  Created by Audrey Serene on 9/25/23.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static let chroma = UTType(exportedAs: "com.chroma.chroma", conformingTo: .json)
}

public struct ChromaDocument: FileDocument {
    public static var readableContentTypes: [UTType] = [.chroma]
    
    public var file: FileModel
    
    public init(_ file: FileModel) {
        self.file = file
    }
    
    public init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.file = try JSONDecoder().decode(FileModel.self, from: data)
    }
    
    public func data() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try encoder.encode(file)
    }
    
    public func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: try data())
    }
}
