//
//  JsonDocument.swift
//  Chroma
//
//  Created by Audrey Serene on 9/19/23.
//

import SwiftUI
import UniformTypeIdentifiers
import Combine

extension UTType {
    static let chroma = UTType(exportedAs: "com.chroma.chroma", conformingTo: .json)
}

struct JsonDocument: FileDocument {
    static public var readableContentTypes: [UTType] = [.chroma, .json]
    static public var writableContentTypes: [UTType] = [.chroma, .json]

    private var data: Data

    init() {
        self.data = Data()
    }

    init<Json: Codable>(_ json: Json) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        self.data = try encoder.encode(json)
    }

    init(configuration: ReadConfiguration) throws {
        self.data = configuration.file.regularFileContents ?? Data()
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: data)
    }

    func json<Json: Codable>() throws -> Json {
        let decoder = JSONDecoder()
        return try decoder.decode(Json.self, from: data)
    }
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
