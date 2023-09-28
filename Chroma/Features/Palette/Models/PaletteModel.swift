//
//  PaletteModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/27/23.
//

import SwiftUI

public struct PaletteModel: Codable {
    public var id = UUID()
    public let name: String
    public let colors: [Color]
}

extension PaletteModel: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.name == rhs.name && lhs.colors.elementsEqual(rhs.colors)
    }
}

public extension PaletteModel {
    static let grays = PaletteModel(
        name: "Grays",
        colors: [
            Color(hex: "#fafafa"),
            Color(hex: "#f4f4f5"),
            Color(hex: "#e4e4e7"),
            Color(hex: "#d4d4d8"),
            Color(hex: "#a1a1aa"),
            Color(hex: "#71717a"),
            Color(hex: "#52525b"),
            Color(hex: "#3f3f46"),
            Color(hex: "#27272a"),
            Color(hex: "#18181b"),
            Color(hex: "#09090b")
        ]
    )
}
