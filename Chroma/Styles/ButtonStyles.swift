//
//  ButtonStyles.swift
//  Chroma
//
//  Created by Audrey Serene on 9/16/23.
//

import SwiftUI

extension Color {
    static var primaryBackground: Color {
        return Color(hue: 0.75, saturation: 0.1, brightness: 0.3, opacity: 0.7)
    }
    static var almostClear: Color {
        return Color(white: 1, opacity: 0.001)
    }
}


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

extension View {
    func active(_ isActive: Bool = true) -> some View {
        return tint(isActive ? .accentColor : .primaryBackground)
    }
}

struct ButtonStateColors {
    let pressed: Color
    let notPressed: Color
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
    
    static func tinted<A: View>(_ configuration: ButtonStyleConfiguration, _ view: A) -> some View {
        return view.background(.tint)
    }

    static func hStack<A: View>(_ configuration: ButtonStyleConfiguration, _ view: A) -> some View {
        return HStack(spacing: 0) { view }
    }

    static func vStack<A: View>(_ configuration: ButtonStyleConfiguration, _ view: A) -> some View {
        return VStack(spacing: 0) { view }
    }
}

func scaledButtonStyle<A: View>(_ configuration: ButtonStyleConfiguration, _ view: A) -> some View {
    return view
        .scaleEffect(configuration.isPressed ? 0.98 : 1)
        .animation(.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0.5), value: configuration.isPressed)
}

func roundedButtonStyle<A: View>(_ configuration: ButtonStyleConfiguration, _ view: A) -> some View {
    return view.cornerRadius(8)
}

func defaultPaddingButtonStyle<A: View>(_ configuration: ButtonStyleConfiguration, _ view: A) -> some View {
    return view.padding(EdgeInsets(top: 3, leading: 9, bottom: 3, trailing: 9))
}

func coloredButtonStyle<A: View>(_ configuration: ButtonStyleConfiguration, _ view: A) -> some View {
    let backgroundColors = ButtonStateColors(
        pressed: Color.white,
        notPressed: Color.gray
    )
    let foregroundColors = ButtonStateColors(
        pressed: Color.black,
        notPressed: Color.black
    )
    return view
        .background(configuration.isPressed ? backgroundColors.pressed : backgroundColors.notPressed)
        .foregroundColor(configuration.isPressed ? foregroundColors.pressed : foregroundColors.notPressed)
}

func tintBackgroundButtonStyle<A: View>(_ configuration: ButtonStyleConfiguration, _ view: A) -> some View {
    return view
        .background(.tint)
}

func hStackButtonStyle<A: View>(_ configuration: ButtonStyleConfiguration, _ view: A) -> some View {
    return HStack(spacing: 0) { view }
}

func vStackButtonStyle<A: View>(_ configuration: ButtonStyleConfiguration, _ view: A) -> some View {
    return VStack(spacing: 0) { view }
}

struct DefaultButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 0) {
            Spacer()
            configuration.label
            Spacer()
        }
            .padding(EdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6))
            .background(.tint)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .scaleEffect(configuration.isPressed ? 0.975 : 1)
    }
}
