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
            MenuButton(exportType.name) {
                Button("PNG") { exportType = .png }
            }.frame(width: 100).fixedSize()
        }
    }
}

struct ExportTypeControl_Previews: PreviewProvider {
    static var previews: some View {
        ExportTypeControl(exportType: .constant(.png))
    }
}
