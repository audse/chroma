//
//  ExportUrlControl.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct ExportUrlControl: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Export as...")
                .font(.label)
                .foregroundColor(.secondary)
            DocumentGroup(viewing: )
        }
    }
}

struct ExportUrlControl_Previews: PreviewProvider {
    static var previews: some View {
        ExportUrlControl()
    }
}
