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
    
    var body: some View {
        HStack(spacing: 0) {
            TextField(value: $value, formatter: getFormatter(), label: {
                Text("Value")
            }).onSubmit { onChange() }
            Stepper {
                Text("")
            } onIncrement: {
                releaseFocus()
                if let newValue = getFormatter().format(value + getStep()) {
                    value = newValue
                    onChange()
                }
            } onDecrement: {
                releaseFocus()
                if let newValue = getFormatter().format(value - getStep()) {
                    value = newValue
                    onChange()
                }
            }.labelsHidden()
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
        NumberTextField(value: Binding.constant(0))
    }
}
