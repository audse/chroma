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
            step: drawSettings.precisionSize,
            rounded: drawSettings.precisionSize.isApprox(1.0),
            onChangeValue: { newValue in
                drawSettings.pixelSize = newValue
            },
            keyboardShortcuts: ("[", "]")
        ).frame(width: 40)
    }
}

struct PixelSizeControl_Previews: PreviewProvider {
    static var previews: some View {
        PixelSizeControl().environmentObject(DrawSettings())
    }
}
