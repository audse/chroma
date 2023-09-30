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
            drawSettings.pixelSize -= drawSettings.precisionSize
        }
        .onKeyPressEvent("]") {
            drawSettings.pixelSize += drawSettings.precisionSize
        }
    }
    
    func getFormatter() -> NumberFormatter {
        let fmt = NumberFormatter()
        fmt.allowsFloats = !drawSettings.precisionSize.isApprox(1.0)
        fmt.maximumFractionDigits = 1
        return fmt
    }
}

struct PixelSizeControl_Previews: PreviewProvider {
    static var previews: some View {
        PixelSizeControl().environmentObject(DrawSettings())
    }
}
