//
//  TintModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/13/23.
//

import SwiftUI

private struct TintColorKey: EnvironmentKey {
    static var defaultValue: Color = .accentColor
}

extension EnvironmentValues {
    var tint: Color {
        get { self[TintColorKey.self] }
        set { self[TintColorKey.self] = newValue }
    }
}

struct TintModifier: ViewModifier {
    var tintColor: Color

    init(_ color: Color) {
        self.tintColor = color
    }

    func body(content: Content) -> some View {
        content.tint(tintColor).environment(\.tint, tintColor)
    }
}

extension View {
    func tinted(_ color: Color) -> some View {
        modifier(TintModifier(color))
    }
}
