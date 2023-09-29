//
//  KeyEventModifier.swift
//  Chroma
//
//  Created by Audrey Serene on 9/29/23.
//

import SwiftUI

struct KeyEventModifier: ViewModifier {
    let key: KeyEquivalent
    let modifiers: EventModifiers?
    
    var onPress: (() -> Void)?
    
    public func body(content: Content) -> some View {
        content
            .overlay(
                Button {
                    if let onPress { onPress() }
                } label: {}
                    .buttonStyle(.plain)
                    .keyboardShortcut(key, modifiers: modifiers ?? [])
            )
    }
}

extension View {
    func onKeyPressEvent(
        _ key: KeyEquivalent,
        modifiers: EventModifiers? = nil,
        onPress: @escaping () -> Void
    ) -> some View {
        modifier(KeyEventModifier(
            key: key,
            modifiers: modifiers,
            onPress: onPress
        ))
    }
}
