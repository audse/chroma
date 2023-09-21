//
//  Panel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/13/23.
//

import SwiftUI

struct PanelModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var padding: EdgeInsets
    var cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(.thinMaterial)
            .cornerRadius(cornerRadius)
            .foregroundStyle(.primary)
            .shadow(color: colorScheme == .dark ? .black.opacity(0.3) : .black.opacity(0.1), radius: cornerRadius / 2)
            .if(colorScheme == .light) { view in
                view.overlay(RoundedRectangle(cornerRadius: cornerRadius - 1)
                    .stroke(.black.opacity(0.05), lineWidth: 1))
            }
    }
}

extension View {
    func panel(
        padding: EdgeInsets = EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8),
        cornerRadius: CGFloat = 8
    ) -> some View {
        modifier(PanelModifier(padding: padding, cornerRadius: cornerRadius))
    }
}
