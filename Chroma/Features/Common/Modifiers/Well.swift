//
//  Well.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

struct WellModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var padding: EdgeInsets
    var cornerRadius: CGFloat
    
    var shadowColor: Color {
        return Color.black
    }
    
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundStyle(.linearGradient(Gradient(
                        colors: [Color(white: 0.9), Color(white: 0.975), .white]),
                        startPoint: .top,
                        endPoint: UnitPoint(x: 0.5, y: 0.5)
                    ))
                    .allowsHitTesting(false)
                    .blendMode(.multiply)
            )
            .if(colorScheme == .light) { view in
                view.overlay(RoundedRectangle(cornerRadius: cornerRadius - 1).stroke(.black.opacity(0.05), lineWidth: 1))
            }
            .background(.black.opacity(0.1))
            .cornerRadius(cornerRadius)
            .foregroundStyle(.primary)
    }
}

extension View {
    func well(padding: EdgeInsets = EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8), cornerRadius: CGFloat = 8) -> some View {
        modifier(WellModifier(padding: padding, cornerRadius: cornerRadius))
    }
}
