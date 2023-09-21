//
//  RemoveFocusOnTap.swift
//  Chroma
//
//  Created by Audrey Serene on 9/20/23.
//

import SwiftUI

func releaseFocus() {
    #if os(iOS)
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    #elseif os(macOS)
    DispatchQueue.main.async {
        NSApp.keyWindow?.makeFirstResponder(nil)
    }
    #endif
}

public struct ReleaseFocusOnTapModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content.simultaneousGesture(TapGesture().onEnded(releaseFocus))
    }
}

extension View {
    /**
     Releases the current mouse focus when this view is tapped.
     This modifier must occur AFTER all other gesture modifiers.
     */
    public func releaseFocusOnTap() -> some View {
        modifier(ReleaseFocusOnTapModifier())
    }
}
