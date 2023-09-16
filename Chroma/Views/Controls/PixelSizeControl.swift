//
//  PixelSize.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct PixelSizeControl: View {
    @EnvironmentObject private var drawSettings: DrawSettings
    @State private var value: CGFloat = 5
    
    @State private var _textValue: String = "5"
    
    var body: some View {
        HStack(spacing: 0) {
            TextField("Value", text: $_textValue)
                .onChange(of: _textValue, perform: setValue)
                .frame(idealWidth: 20, maxWidth: 20)
            Stepper(
                "",
                value: $value,
                in: 1...9,
                step: 1,
                onEditingChanged: { isEditing in
                    setValue(value)
                }
            )
        }
    }
    
    func setValue(_ newValue: String) {
        if case Optional.some(let val) = Int(_textValue) {
            setValue(CGFloat(val))
        }
    }
    
    func setValue(_ newValue: CGFloat) {
        value = newValue.clamp(low: 1, high: 9)
        drawSettings.pixelSize = value
        _textValue = String("\(value)".split(separator: ".")[0])
    }
}

struct PixelSizeControl_Previews: PreviewProvider {
    static var previews: some View {
        PixelSizeControl().environmentObject(DrawSettings())
    }
}
