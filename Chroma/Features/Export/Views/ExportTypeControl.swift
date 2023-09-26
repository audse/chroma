//
//  ExportTypeControl.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI
import Extensions

struct ExportTypeControl: View {
    @Binding var exportType: ExportType

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("File type")
                .font(.label)
                .foregroundColor(.secondary)
            MenuButton(getText()) {
                Button("Chroma") { exportType = .chroma }
                Button("PNG") { exportType = .png }
            }.frame(width: 100).fixedSize()
        }
    }

    func getText() -> String {
        switch exportType {
        case .chroma: return "Chroma"
        case .png: return "PNG"
        }
    }
}

struct ExportTypeControl_Previews: PreviewProvider {
    static var previews: some View {
        ExportTypeControl(exportType: .constant(.chroma))
    }
}
