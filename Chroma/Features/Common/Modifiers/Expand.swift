//
//  Expand.swift
//  Chroma
//
//  Created by Audrey Serene on 9/12/23.
//

import SwiftUI

struct ExpandModifier: ViewModifier {
    var alignment: Alignment = .center
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
}

struct ExpandWidthModifier: ViewModifier {
    var alignment: Alignment = .center
    var idealHeight: CGFloat?
    var maxHeight: CGFloat?
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, idealHeight: idealHeight, maxHeight: maxHeight, alignment: alignment)
    }
}

struct ExpandHeightModifier: ViewModifier {
    var alignment: Alignment = .center
    var idealWidth: CGFloat?
    var maxWidth: CGFloat?
    func body(content: Content) -> some View {
        content
            .frame(idealWidth: idealWidth, maxWidth: maxWidth, maxHeight: .infinity, alignment: alignment)
    }
}

extension View {
    func expand(alignment: Alignment = .center) -> some View {
        modifier(ExpandModifier(alignment: alignment))
    }
    func expandWidth(
        alignment: Alignment = .center,
        idealHeight: CGFloat? = nil,
        maxHeight: CGFloat? = nil
    ) -> some View {
        modifier(ExpandWidthModifier(alignment: alignment, idealHeight: idealHeight, maxHeight: maxHeight))
    }
    func expandHeight(
        alignment: Alignment = .center,
        idealWidth: CGFloat? = nil,
        maxWidth: CGFloat? = nil
    ) -> some View {
        modifier(ExpandHeightModifier(alignment: alignment, idealWidth: idealWidth, maxWidth: maxWidth))
    }
}
