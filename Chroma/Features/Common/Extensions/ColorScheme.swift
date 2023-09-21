//
//  ColorScheme.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

extension ColorScheme: Codable {
    var name: String {
        switch self {
        case .dark: return "dark"
        case .light: return "light"
        default: return "custom"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case name
    }
    
    public init(_ name: String) {
        switch name {
        case "dark": self = .dark
        case "light": self = .light
        default: self = .dark
        }
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let name: String = try values.decode(String.self, forKey: .name)
        self.init(name)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: CodingKeys.name)
    }
}
