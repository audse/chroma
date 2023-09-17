//
//  ButtonStyles.swift
//  Chroma
//
//  Created by Audrey Serene on 9/16/23.
//

import SwiftUI

struct ButtonColorStyleModifier: ViewModifier {
    var colorStyle: ButtonColorStyle
    
    init(_ type: ButtonColorStyleType, _ baseColor: Color) {
        self.colorStyle = ButtonColorStyle(type, baseColor)
    }
    
    func body(content: Content) -> some View {
        content.background(colorStyle.backgroundColor)
            .border(colorStyle.borderColor)
            .foregroundColor(colorStyle.foregroundColor)
    }
}

struct ButtonAccentStyleModifier: ViewModifier {
    @Environment(\.tint) var tint
    var type: ButtonColorStyleType
    
    init(_ type: ButtonColorStyleType) {
        self.type = type
    }
    
    func body(content: Content) -> some View {
        let colorStyle = ButtonColorStyle(type, tint)
        content.background(colorStyle.backgroundColor)
            .border(colorStyle.borderColor)
            .foregroundColor(colorStyle.foregroundColor)
    }
}

extension View {
    func buttonColorStyle(_ type: ButtonColorStyleType, _ baseColor: Color) -> some View {
        modifier(ButtonColorStyleModifier(type, baseColor))
    }
    func buttonAccentStyle(_ type: ButtonColorStyleType) -> some View {
        modifier(ButtonAccentStyleModifier(type))
    }
}

extension Btn {
    static func filledAccent<A: View>(_ configuration: ButtonStyleConfiguration, _ view: A) -> some View {
        return view.buttonAccentStyle(.filled)
    }
    
    static func outlinedAccent<A: View>(_ configuration: ButtonStyleConfiguration, _ view: A) -> some View {
        return view.buttonAccentStyle(.outlined)
    }
    
    static func subtleAccent<A: View>(_ configuration: ButtonStyleConfiguration, _ view: A) -> some View {
        return view.buttonAccentStyle(.subtle)
    }
    
    static func textAccent<A: View>(_ configuration: ButtonStyleConfiguration, _ view: A) -> some View {
        return view.buttonAccentStyle(.text)
    }
}
