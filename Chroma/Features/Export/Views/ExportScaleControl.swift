//
//  ExportScaleControl.swift
//  Chroma
//
//  Created by Audrey Serene on 9/19/23.
//

import SwiftUI

struct ExportScaleControl: View {
    @Binding var exportScale: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Scale").font(.label).foregroundColor(.secondary)
            NumberTextField(
                value: $exportScale,
                min: 0.0,
                step: 0.01,
                formatter: getFormatter()
            ).frame(maxWidth: 60)
        }
    }

    func getFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.allowsFloats = true
        formatter.maximumFractionDigits = 2
        return formatter
    }
}

struct ExportScaleControl_Previews: PreviewProvider {
    static var previews: some View {
        ExportScaleControl(
            exportScale: .constant(1)
        )
    }
}
