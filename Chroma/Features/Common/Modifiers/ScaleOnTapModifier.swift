//
//  ScaleOnTapModifier.swift
//  Chroma
//
//  Created by Audrey Serene on 9/24/23.
//

import SwiftUI

public struct ScaleOnTapModifier: ViewModifier {
    public let seconds: CGFloat
    public let amount: CGFloat
    
    @State private var isPressed: Bool = false {
        didSet {
            if isPressed { DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { isPressed = false } }
        }
    }
    
    init(seconds: CGFloat? = nil, amount: CGFloat? = nil) {
        self.seconds = seconds ?? 0.15 / 2
        self.amount = amount ?? 0.03
    }
    
    public func body(content: Content) -> some View {
        return content
            .simultaneousGesture(TapGesture().onEnded { isPressed = true })
            .scaleEffect(isPressed ? 1 - amount : 1)
            .animation(.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0.5), value: isPressed)
    }
}

extension View {
    /**
     This must come AFTER all other tap gestures.
     */
    public func scaleOnTap(seconds: CGFloat? = nil, amount: CGFloat? = nil) -> some View {
        modifier(ScaleOnTapModifier(seconds: seconds, amount: amount))
    }
}
