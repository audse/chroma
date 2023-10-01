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
        NumberStepper(
            value: $drawSettings.pixelSize,
            range: 1...9,
            step: drawSettings.precisionSize,
            formatter: getFormatter(),
            fontSize: 14,
            expectedDigits: 3
        )
        .onKeyPressEvent("[") {
            drawSettings.pixelSize -= 1
        }
        .onKeyPressEvent("]") {
            drawSettings.pixelSize += 1
        }
    }
    
    func getFormatter() -> NumberFormatter {
        let fmt = NumberFormatter()
        fmt.allowsFloats = false
        return fmt
    }
}

struct PixelSizeControl_Previews: PreviewProvider {
    static var previews: some View {
        PixelSizeControl().environmentObject(DrawSettings())
    }
}
