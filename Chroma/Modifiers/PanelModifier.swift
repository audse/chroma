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

extension View {
    func panel(padding: EdgeInsets = EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8), cornerRadius: CGFloat = 8) -> some View {
        modifier(PanelModifier(padding: padding, cornerRadius: cornerRadius))
    }
}
