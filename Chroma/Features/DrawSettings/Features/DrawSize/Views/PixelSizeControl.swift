//
//  PixelSize.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct PixelSizeControl: View {
    @EnvironmentObject private var drawSettings: DrawSettings
    @State private var value: Double = 5

    var body: some View {
        NumberTextField(
            value: $value,
            min: 1,
            max: 9,
            step: 1,
            rounded: true,
            onChangeValue: { newValue in
                drawSettings.pixelSize = newValue
            },
            keyboardShortcuts: ("[", "]")
        ).frame(width: 30)
    }
}

struct PixelSizeControl_Previews: PreviewProvider {
    static var previews: some View {
        PixelSizeControl().environmentObject(DrawSettings())
    }
}
