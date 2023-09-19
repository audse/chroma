//
//  ExportPage.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI

struct ExportPage: View {
    var body: some View {
        VStack(alignment: .leading) {
            ExportTypeControl()
        }
    }
}

struct ExportPage_Previews: PreviewProvider {
    static var previews: some View {
        ExportPage()
            .environmentObject(ExportSettingsModel())
    }
}
