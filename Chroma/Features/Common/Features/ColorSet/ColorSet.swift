//
//  ColorSet.swift
//  Chroma
//
//  Created by Audrey Serene on 9/30/23.
//

import SwiftUI

@dynamicMemberLookup
public struct ColorSet {
    public let shades: [Int: Color]
    
    init(_ shades: [Int: Color]) {
        self.shades = shades
    }
    
    public func get(_ shade: Int) -> Color {
        if let color = shades[shade] {
            return color
        }
        return .white
    }
    
    public func list() -> [Color] {
        shades.map { (_, color) in color }
    }
    
    subscript(dynamicMember member: String) -> Color {
        return shades[Int(member) ?? 0, default: .white]
    }
}

public extension ColorSet {
    static let zincs = ColorSet([
        50: Color(hex: "#fafafa"),
        100: Color(hex: "#f4f4f5"),
        200: Color(hex: "#e4e4e7"),
        300: Color(hex: "#d4d4d8"),
        400: Color(hex: "#a1a1aa"),
        500: Color(hex: "#71717a"),
        600: Color(hex: "#52525b"),
        700: Color(hex: "#3f3f46"),
        800: Color(hex: "#27272a"),
        900: Color(hex: "#18181b"),
        950: Color(hex: "#09090b")
    ])
    
    static let reds = ColorSet([
        50: Color(hex: "#fef2f2"),
        100: Color(hex: "#fee2e2"),
        200: Color(hex: "#fecaca"),
        300: Color(hex: "#fca5a5"),
        400: Color(hex: "#f87171"),
        500: Color(hex: "#ef4444"),
        600: Color(hex: "#dc2626"),
        700: Color(hex: "#b91c1c"),
        800: Color(hex: "#991b1b"),
        900: Color(hex: "#7f1d1d"),
        950: Color(hex: "#450a0a")
    ])
    
    static let oranges = ColorSet([
        50: Color(hex: "#fff7ed"),
        100: Color(hex: "#ffedd5"),
        200: Color(hex: "#fed7aa"),
        300: Color(hex: "#fdba74"),
        400: Color(hex: "#fb923c"),
        500: Color(hex: "#f97316"),
        600: Color(hex: "#ea580c"),
        700: Color(hex: "#c2410c"),
        800: Color(hex: "#9a3412"),
        900: Color(hex: "#7c2d12"),
        950: Color(hex: "#431407")
    ])

    static let ambers = ColorSet([
        50: Color(hex: "#fffbeb"),
        100: Color(hex: "#fef3c7"),
        200: Color(hex: "#fde68a"),
        300: Color(hex: "#fcd34d"),
        400: Color(hex: "#fbbf24"),
        500: Color(hex: "#f59e0b"),
        600: Color(hex: "#d97706"),
        700: Color(hex: "#b45309"),
        800: Color(hex: "#92400e"),
        900: Color(hex: "#78350f"),
        950: Color(hex: "#451a03")
    ])
    
    static let yellows = ColorSet([
        50: Color(hex: "#fefce8"),
        100: Color(hex: "#fef9c3"),
        200: Color(hex: "#fef08a"),
        300: Color(hex: "#fde047"),
        400: Color(hex: "#facc15"),
        500: Color(hex: "#eab308"),
        600: Color(hex: "#ca8a04"),
        700: Color(hex: "#a16207"),
        800: Color(hex: "#854d0e"),
        900: Color(hex: "#713f12"),
        950: Color(hex: "#422006"),
    ])

    static let limes = ColorSet([
        50: Color(hex: "#f7fee7"),
        100: Color(hex: "#ecfccb"),
        200: Color(hex: "#d9f99d"),
        300: Color(hex: "#bef264"),
        400: Color(hex: "#a3e635"),
        500: Color(hex: "#84cc16"),
        600: Color(hex: "#65a30d"),
        700: Color(hex: "#4d7c0f"),
        800: Color(hex: "#3f6212"),
        900: Color(hex: "#365314"),
        950: Color(hex: "#1a2e05")
    ])

    static let greens = ColorSet([
        50: Color(hex: "#f0fdf4"),
        100: Color(hex: "#dcfce7"),
        200: Color(hex: "#bbf7d0"),
        300: Color(hex: "#86efac"),
        400: Color(hex: "#4ade80"),
        500: Color(hex: "#22c55e"),
        600: Color(hex: "#16a34a"),
        700: Color(hex: "#15803d"),
        800: Color(hex: "#166534"),
        900: Color(hex: "#14532d"),
        950: Color(hex: "#052e16")
    ])

    static let emeralds = ColorSet([
        50: Color(hex: "#ecfdf5"),
        100: Color(hex: "#d1fae5"),
        200: Color(hex: "#a7f3d0"),
        300: Color(hex: "#6ee7b7"),
        400: Color(hex: "#34d399"),
        500: Color(hex: "#10b981"),
        600: Color(hex: "#059669"),
        700: Color(hex: "#047857"),
        800: Color(hex: "#065f46"),
        900: Color(hex: "#064e3b"),
        950: Color(hex: "#022c22")
    ])

    static let teals = ColorSet([
        50: Color(hex: "#f0fdfa"),
        100: Color(hex: "#ccfbf1"),
        200: Color(hex: "#99f6e4"),
        300: Color(hex: "#5eead4"),
        400: Color(hex: "#2dd4bf"),
        500: Color(hex: "#14b8a6"),
        600: Color(hex: "#0d9488"),
        700: Color(hex: "#0f766e"),
        800: Color(hex: "#115e59"),
        900: Color(hex: "#134e4a"),
        950: Color(hex: "#042f2e")
    ])

    static let cyans = ColorSet([
        50: Color(hex: "#ecfeff"),
        100: Color(hex: "#cffafe"),
        200: Color(hex: "#a5f3fc"),
        300: Color(hex: "#67e8f9"),
        400: Color(hex: "#22d3ee"),
        500: Color(hex: "#06b6d4"),
        600: Color(hex: "#0891b2"),
        700: Color(hex: "#0e7490"),
        800: Color(hex: "#155e75"),
        900: Color(hex: "#164e63"),
        950: Color(hex: "#083344")
    ])

    static let skys = ColorSet([
        50: Color(hex: "#f0f9ff"),
        100: Color(hex: "#e0f2fe"),
        200: Color(hex: "#bae6fd"),
        300: Color(hex: "#7dd3fc"),
        400: Color(hex: "#38bdf8"),
        500: Color(hex: "#0ea5e9"),
        600: Color(hex: "#0284c7"),
        700: Color(hex: "#0369a1"),
        800: Color(hex: "#075985"),
        900: Color(hex: "#0c4a6e"),
        950: Color(hex: "#082f49")
    ])

    static let blues = ColorSet([
        50: Color(hex: "#eff6ff"),
        100: Color(hex: "#dbeafe"),
        200: Color(hex: "#bfdbfe"),
        300: Color(hex: "#93c5fd"),
        400: Color(hex: "#60a5fa"),
        500: Color(hex: "#3b82f6"),
        600: Color(hex: "#2563eb"),
        700: Color(hex: "#1d4ed8"),
        800: Color(hex: "#1e40af"),
        900: Color(hex: "#1e3a8a"),
        950: Color(hex: "#172554")
    ])

    static let indigos = ColorSet([
        50: Color(hex: "#eef2ff"),
        100: Color(hex: "#e0e7ff"),
        200: Color(hex: "#c7d2fe"),
        300: Color(hex: "#a5b4fc"),
        400: Color(hex: "#818cf8"),
        500: Color(hex: "#6366f1"),
        600: Color(hex: "#4f46e5"),
        700: Color(hex: "#4338ca"),
        800: Color(hex: "#3730a3"),
        900: Color(hex: "#312e81"),
        950: Color(hex: "#1e1b4b")
    ])

    static let violets = ColorSet([
        50: Color(hex: "#f5f3ff"),
        100: Color(hex: "#ede9fe"),
        200: Color(hex: "#ddd6fe"),
        300: Color(hex: "#c4b5fd"),
        400: Color(hex: "#a78bfa"),
        500: Color(hex: "#8b5cf6"),
        600: Color(hex: "#7c3aed"),
        700: Color(hex: "#6d28d9"),
        800: Color(hex: "#5b21b6"),
        900: Color(hex: "#4c1d95"),
        950: Color(hex: "#2e1065")
    ])

    static let purples = ColorSet([
        50: Color(hex: "#faf5ff"),
        100: Color(hex: "#f3e8ff"),
        200: Color(hex: "#e9d5ff"),
        300: Color(hex: "#d8b4fe"),
        400: Color(hex: "#c084fc"),
        500: Color(hex: "#a855f7"),
        600: Color(hex: "#9333ea"),
        700: Color(hex: "#7e22ce"),
        800: Color(hex: "#6b21a8"),
        900: Color(hex: "#581c87"),
        950: Color(hex: "#3b0764")
    ])

    static let fuchsias = ColorSet([
        50: Color(hex: "#fdf4ff"),
        100: Color(hex: "#fae8ff"),
        200: Color(hex: "#f5d0fe"),
        300: Color(hex: "#f0abfc"),
        400: Color(hex: "#e879f9"),
        500: Color(hex: "#d946ef"),
        600: Color(hex: "#c026d3"),
        700: Color(hex: "#a21caf"),
        800: Color(hex: "#86198f"),
        900: Color(hex: "#701a75"),
        950: Color(hex: "#4a044e")
    ])

    static let pinks = ColorSet([
        50: Color(hex: "#fdf2f8"),
        100: Color(hex: "#fce7f3"),
        200: Color(hex: "#fbcfe8"),
        300: Color(hex: "#f9a8d4"),
        400: Color(hex: "#f472b6"),
        500: Color(hex: "#ec4899"),
        600: Color(hex: "#db2777"),
        700: Color(hex: "#be185d"),
        800: Color(hex: "#9d174d"),
        900: Color(hex: "#831843"),
        950: Color(hex: "#500724")
    ])
    
    static let roses = ColorSet([
        50: Color(hex: "#fff1f2"),
        100: Color(hex: "#ffe4e6"),
        200: Color(hex: "#fecdd3"),
        300: Color(hex: "#fda4af"),
        400: Color(hex: "#fb7185"),
        500: Color(hex: "#f43f5e"),
        600: Color(hex: "#e11d48"),
        700: Color(hex: "#be123c"),
        800: Color(hex: "#9f1239"),
        900: Color(hex: "#881337"),
        950: Color(hex: "#4c0519")
    ])
}
