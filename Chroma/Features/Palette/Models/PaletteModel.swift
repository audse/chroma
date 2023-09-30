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
        colors: ColorSet.zincs.list()
    )

    static let pastels = PaletteModel(
        name: "Pastels",
        colors: [
            ColorSet.reds.300,
            ColorSet.oranges.300,
            ColorSet.ambers.200,
            ColorSet.yellows.200,
            ColorSet.limes.200,
            ColorSet.greens.300,
            ColorSet.emeralds.300,
            ColorSet.teals.300,
            ColorSet.cyans.300,
            ColorSet.skys.300,
            ColorSet.blues.300,
            ColorSet.indigos.300,
            ColorSet.violets.300,
            ColorSet.purples.300,
            ColorSet.fuchsias.300,
            ColorSet.pinks.300,
            ColorSet.roses.300
        ]
    )
    
    static let brights = PaletteModel(
        name: "Brights",
        colors: [
            ColorSet.reds.500,
            ColorSet.oranges.500,
            ColorSet.ambers.300,
            ColorSet.yellows.300,
            ColorSet.limes.400,
            ColorSet.greens.500,
            ColorSet.emeralds.500,
            ColorSet.teals.500,
            ColorSet.cyans.500,
            ColorSet.skys.500,
            ColorSet.blues.500,
            ColorSet.indigos.500,
            ColorSet.violets.500,
            ColorSet.purples.500,
            ColorSet.fuchsias.500,
            ColorSet.pinks.500,
            ColorSet.roses.500
        ]
    )

    static let jewelTones = PaletteModel(
        name: "Jewel Tones",
        colors: [
            ColorSet.reds.700,
            ColorSet.oranges.700,
            ColorSet.ambers.700,
            ColorSet.yellows.700,
            ColorSet.limes.700,
            ColorSet.greens.700,
            ColorSet.emeralds.700,
            ColorSet.teals.700,
            ColorSet.cyans.700,
            ColorSet.skys.700,
            ColorSet.blues.700,
            ColorSet.indigos.700,
            ColorSet.violets.700,
            ColorSet.purples.700,
            ColorSet.fuchsias.700,
            ColorSet.pinks.700,
            ColorSet.roses.700
        ]
    )
    
    static let reds = PaletteModel(
        name: "Reds",
        colors: ColorSet.reds.list()
    )
    
    static let oranges = PaletteModel(
        name: "Oranges",
        colors: ColorSet.oranges.list()
    )
    
    static let ambers = PaletteModel(
        name: "Ambers",
        colors: ColorSet.ambers.list()
    )
    
    static let yellows = PaletteModel(
        name: "Yellows",
        colors: ColorSet.yellows.list()
    )
    
    static let limes = PaletteModel(
        name: "Limes",
        colors: ColorSet.limes.list()
    )
    
    static let greens = PaletteModel(
        name: "Greens",
        colors: ColorSet.greens.list()
    )
    
    static let emeralds = PaletteModel(
        name: "Emeralds",
        colors: ColorSet.emeralds.list()
    )
    
    static let teals = PaletteModel(
        name: "Teals",
        colors: ColorSet.teals.list()
    )

    static let cyans = PaletteModel(
        name: "Cyans",
        colors: ColorSet.cyans.list()
    )

    static let skys = PaletteModel(
        name: "Skys",
        colors: ColorSet.skys.list()
    )
    
    static let blues = PaletteModel(
        name: "Blues",
        colors: ColorSet.blues.list()
    )
    
    static let indigos = PaletteModel(
        name: "Indigos",
        colors: ColorSet.indigos.list()
    )
    
    static let violets = PaletteModel(
        name: "Violets",
        colors: ColorSet.violets.list()
    )
    
    static let purples = PaletteModel(
        name: "Purples",
        colors: ColorSet.purples.list()
    )
    
    static let fuchsias = PaletteModel(
        name: "Fuchsias",
        colors: ColorSet.fuchsias.list()
    )
    
    static let pinks = PaletteModel(
        name: "Pinks",
        colors: ColorSet.pinks.list()
    )
    
    static let roses = PaletteModel(
        name: "Roses",
        colors: ColorSet.roses.list()
    )
}
