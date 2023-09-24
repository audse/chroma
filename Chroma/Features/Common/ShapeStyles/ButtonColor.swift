//
//  ButtonColor.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

enum ButtonColorStyleType {
    case filled
    case outlined
    case subtle
    case text
}

struct ButtonColorStyle: ShapeStyle {
    var type: ButtonColorStyleType
    var baseColor: Color
    var colorScheme: ColorScheme?

    var backgroundColor: Color {
        switch type {
        case .filled: return baseColor
        case .outlined, .text: return .clear
        case .subtle: return baseColor.opacity(0.2)
        }
    }

    var foregroundColor: Color {
        if type == .filled {
            if baseColor.opacity < 0.1 {
                return .primary
            }
            return contrasting
        }
        if colorScheme != nil {
            switch colorScheme {
            case .dark:
                let contrast = baseColor.contrast(with: contrasting)
                return baseColor.lighten(max(0.5 - contrast, 0.0))
            case .light:
                let contrast = baseColor.contrast(with: contrasting)
                return baseColor.darken(max(0.5 - contrast, 0.0))
            default: return baseColor
            }
        }
        return baseColor
    }

    var borderColor: Color {
        switch type {
        case .outlined: return baseColor.opacity(0.4)
        default: return .clear
        }
    }

    var contrasting: Color {
        return baseColor.isDark ? .white.opacity(0.9) : .black.opacity(0.9)
    }

    init(_ type: ButtonColorStyleType, _ baseColor: Color) {
        self.type = type
        self.baseColor = baseColor
    }

    func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        var style = self
        style.colorScheme = environment.colorScheme
        return style
    }
}
