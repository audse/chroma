//
//  ColorPicker.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct ColorControl: View {
    @EnvironmentObject private var drawSettings: DrawSettings

    var body: some View {
        HStack(spacing: 2) {
            ColorPicker("Color", selection: $drawSettings.color)
                .labelsHidden()
            ColorEyedropper()
        }
    }
}

struct ColorControl_Previews: PreviewProvider {
    static var previews: some View {
        ColorControl().environmentObject(DrawSettings())
    }
}
