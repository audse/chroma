//
//  ExportTypeControl.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI

struct ExportTypeControl: View {
    @EnvironmentObject var exportSettings: ExportSettingsModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("File type")
                .font(.label)
                .foregroundColor(.secondary)
            MenuButton(getText()) {
                Button("PNG") {
                    exportSettings.type = .png
                }
            }.frame(width: 100).fixedSize()
        }
    }
    
    func getText() -> String {
        switch exportSettings.type {
            case .png: return "PNG"
//            default: return "Image"
        }
    }
                
}

struct ExportTypeControl_Previews: PreviewProvider {
    static var previews: some View {
        ExportTypeControl()
            .environmentObject(ExportSettingsModel())
    }
}
