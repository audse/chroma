//
//  NumberTextField.swift
//  Chroma
//
//  Created by Audrey Serene on 9/16/23.
//

import SwiftUI

struct NumberTextField: View {
    @Binding var value: Double
    @State var min: Double = -.infinity
    @State var max: Double = .infinity
    @State var step: Double = 1
    @State var rounded: Bool = false
    @State var formatter: NumberFormatter = NumberFormatter()
    @State var onChangeValue: ((CGFloat) -> Void)?
    @State var keyboardShortcuts: (KeyEquivalent, KeyEquivalent)? = nil
    
    var body: some View {
        HStack(spacing: 0) {
            TextField(value: $value, formatter: getFormatter(), label: {
                Text("Value")
            }).onSubmit { onChange() }
            Stepper {
                Text("")
            } onIncrement: {
                releaseFocus()
                setValue(value + getStep())
            } onDecrement: {
                releaseFocus()
                setValue(value - getStep())
            }.labelsHidden()
            if let shortcuts = keyboardShortcuts {
                Button("") {
                    setValue(value - getStep())
                }.keyboardShortcut(shortcuts.0, modifiers: [])
                    .buttonStyle(.plain)
                Button("") {
                    setValue(value + getStep())
                }.keyboardShortcut(shortcuts.1, modifiers: [])
                    .buttonStyle(.plain)
            }
        }
    }
    
    func setValue(_ newValue: Double) {
        if let newValue = getFormatter().format(newValue) {
            value = newValue
            onChange()
        }
    }
    
    func getStep() -> Double {
        return rounded ? round(Swift.max(step, 1)) : step
    }
    
    func getFormatter() -> NumberFormatter {
        formatter.minimum = min as NSNumber
        formatter.maximum = max as NSNumber
        formatter.allowsFloats = !rounded
        return formatter
    }
    
    func onChange() {
        if let onChangeValue = self.onChangeValue {
            onChangeValue(value)
        }
    }
    
}

struct NumberTextField_Previews: PreviewProvider {
    static var previews: some View {
        NumberTextField(value: Binding.constant(0), keyboardShortcuts: ("[", "]"))
    }
}
