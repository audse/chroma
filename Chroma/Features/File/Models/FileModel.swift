//
//  FileModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI
import Combine

public final class FileModel: ObservableObject, Identifiable {
    @Published public private(set) var id: UUID
    @Published public var name: String
    
    private var _artboardCancellable: AnyCancellable?
    @Published public private(set) var artboard: ArtboardModel {
        didSet { _artboardCancellable = artboard.objectWillChange.sink { _ in
            self.objectWillChange.send()
        } }
    }
    
    init(
        id: UUID = UUID(),
        name: String = "Untitled",
        artboard: ArtboardModel
    ) {
        self.id = id
        self.name = name
        self.artboard = artboard
    }
}

extension FileModel: Codable {
    internal enum CodingKeys: CodingKey {
        case id
        case name
        case artboard
    }
    
    public convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.init(
            id: try values.decode(UUID.self, forKey: .id),
            name: try values.decode(String.self, forKey: .name),
            artboard: try values.decode(ArtboardModel.self, forKey: .artboard)
        )
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(artboard, forKey: .artboard)
    }
}

extension FileModel {
    
    // swiftlint:disable:next identifier_name
    static func Empty(_ name: String = "New Artboard") -> FileModel {
        return FileModel(
            name: name,
            artboard: ArtboardModel().withNewLayer()
        )
    }
    
    func setFile(_ file: FileModel) {
        self.id = file.id
        self.name = file.name
        self.artboard = file.artboard
    }
    
}

private struct FileKey: EnvironmentKey {
    static var defaultValue = FileModel.Empty()
}

extension EnvironmentValues {
    var file: FileModel {
        get { self[FileKey.self] }
        set { self[FileKey.self] = newValue }
    }
}
