//
//  ActiveTint.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

struct ActiveTintModifier: ViewModifier {
    var isActive: Bool
    @Environment(\.colorScheme) private var colorScheme

    func body(content: Content) -> some View {
        return content.tinted(isActive ? .accentColor : (
            colorScheme == .dark ? Color.primaryBackgroundDark : Color.primaryBackgroundLight
        ))
    }
}

extension View {
    func active(_ isActive: Bool = true) -> some View {
        return modifier(ActiveTintModifier(isActive: isActive))
    }
}
