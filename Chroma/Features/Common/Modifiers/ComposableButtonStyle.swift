//
//  ComposableButtonStyle.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

typealias ButtonStyleClosure<A: View, B: View> = (ButtonStyleConfiguration, A) -> B

precedencegroup ForwardComposition {
    associativity: left
}

infix operator |>: ForwardComposition

func |> <A: View, B: View, C: View>(
    _ f: @escaping ButtonStyleClosure<A, B>,
    _ g: @escaping ButtonStyleClosure<B, C>
) -> ButtonStyleClosure<A, C> {
    return { configuration, a in
        g(configuration, f(configuration, a))
    }
}

struct ComposableButtonStyle<B: View>: ButtonStyle {
    let buttonStyleClosure: ButtonStyleClosure<ButtonStyleConfiguration.Label, B>

    init(_ buttonStyleClosure: @escaping ButtonStyleClosure<ButtonStyleConfiguration.Label, B>) {
        self.buttonStyleClosure = buttonStyleClosure
    }

    func makeBody(configuration: Configuration) -> some View {
        return buttonStyleClosure(configuration, configuration.label)
    }
}

extension Button {
    func composableStyle<B: View>(_ buttonStyleClosure: @escaping ButtonStyleClosure<ButtonStyleConfiguration.Label, B>) -> some View {
        return self.buttonStyle(ComposableButtonStyle(buttonStyleClosure))
    }
}

extension View {
    func composableButtonStyle<B: View>(_ buttonStyleClosure: @escaping ButtonStyleClosure<ButtonStyleConfiguration.Label, B>) -> some View {
        return self.buttonStyle(ComposableButtonStyle(buttonStyleClosure))
    }
}

struct Btn {
    static func scaled<A: View>(_ configuration: ButtonStyleConfiguration, _ view: A) -> some View {
        return view
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0.5), value: configuration.isPressed)
    }
    
    static func rounded<A: View>(_ configuration: ButtonStyleConfiguration, _ view: A) -> some View {
        return view.cornerRadius(6)
    }
    
    static func defaultPadding<A: View>(_ configuration: ButtonStyleConfiguration, _ view: A) -> some View {
        return view.padding(EdgeInsets(top: 3, leading: 9, bottom: 3, trailing: 9))
    }

    static func hStack<A: View>(_ configuration: ButtonStyleConfiguration, _ view: A) -> some View {
        return HStack(spacing: 0) { view }
    }

    static func vStack<A: View>(_ configuration: ButtonStyleConfiguration, _ view: A) -> some View {
        return VStack(spacing: 0) { view }
    }
}
