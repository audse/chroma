//
//  PanelModifier.swift
//  Chroma
//
//  Created by Audrey Serene on 9/13/23.
//

import SwiftUI

struct PanelModifier: ViewModifier {
    var padding: EdgeInsets
    var cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(.thinMaterial)
            .cornerRadius(cornerRadius)
            .foregroundStyle(.primary)
            .shadow(radius: cornerRadius / 2)
    }
}

struct WellModifier: ViewModifier {
    var padding: EdgeInsets
    var cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundStyle(.shadow(.inner(color: Color.black.opacity(0.2), radius: cornerRadius)))
                    .blendMode(.multiply)
                    .allowsHitTesting(false)
            )
            .background(Color.black.opacity(0.1))
            .cornerRadius(cornerRadius)
            .foregroundStyle(.primary)
    }
}

extension View {
    func panel(padding: EdgeInsets = EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8), cornerRadius: CGFloat = 8) -> some View {
        modifier(PanelModifier(padding: padding, cornerRadius: cornerRadius))
    }
    func well(padding: EdgeInsets = EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8), cornerRadius: CGFloat = 8) -> some View {
        modifier(WellModifier(padding: padding, cornerRadius: cornerRadius))
    }
}
