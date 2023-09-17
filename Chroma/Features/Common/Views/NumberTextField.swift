//
//  NumberTextField.swift
//  Chroma
//
//  Created by Audrey Serene on 9/16/23.
//

import SwiftUI

private func toText(_ rounded: Bool, _ value: CGFloat) -> String {
    return rounded
        ? String("\(value)".split(separator: ".")[0])
        : String("\(value)")
}

struct NumberTextField: View {
    var value: Binding<CGFloat>
    @State var min: CGFloat = -.infinity
    @State var max: CGFloat = .infinity
    @State var step: CGFloat = 0
    @State var rounded: Bool = false
    @State var onChangeValue: ((CGFloat) -> Void)?
    
    @State var textValue: String
    
    init(
        value: Binding<CGFloat>,
        min: CGFloat = -.infinity,
        max: CGFloat = .infinity,
        step: CGFloat = 0,
        rounded: Bool = false,
        onChangeValue: ((CGFloat) -> Void)? = nil
    ) {
        self.value = value
        self.min = min
        self.max = max
        self.step = step
        self.rounded = rounded
        self.onChangeValue = onChangeValue
        self.textValue = toText(rounded, value.wrappedValue)
    }
    
    var body: some View {
        HStack(spacing: 0) {
            TextField("Value", text: $textValue).onChange(of: textValue) { newValue in
                if let val = Double(newValue) {
                    setValue(CGFloat(val))
                }
            }
            Stepper(
                "",
                value: value,
                in: min...max,
                step: step
            ).onChange(of: value.wrappedValue) { newValue in
                setValue(newValue)
                textValue = toText(rounded, value.wrappedValue)
            }.labelsHidden()
        }
    }
    
    func setValue(_ newValue: CGFloat) {
        value.wrappedValue = rounded ? round(newValue.clamp(low: min, high: max)) : newValue.clamp(low: min, high: max)
        if let onChangeValue = self.onChangeValue {
            onChangeValue(value.wrappedValue)
        }
    }
    
}

struct NumberTextField_Previews: PreviewProvider {
    static var previews: some View {
        NumberTextField(value: Binding.constant(0))
    }
}
