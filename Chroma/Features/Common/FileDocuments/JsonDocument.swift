//
//  JsonDocument.swift
//  Chroma
//
//  Created by Audrey Serene on 9/19/23.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static let chroma = UTType(exportedAs: "chroma", conformingTo: .json)
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
