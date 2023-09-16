//
//  ScaleTypeButtons.swift
//  Chroma
//
//  Created by Audrey Serene on 9/14/23.
//

import SwiftUI

struct ScaleTypeButtons: View {
    @EnvironmentObject var drawSettings: DrawSettings
    
    var body: some View {
        HStack {
            Button {
                drawSettings.scaleType = .even
            } label: {
                Label("2", systemImage: "divide")
            }.tint(drawSettings.scaleType == .even ? .accentColor : .primary)
            Button {
                drawSettings.scaleType = .odd
            } label: {
                Label("3", systemImage: "divide")
            }.tint(drawSettings.scaleType == .odd ? .accentColor : .primary)
        }
    }
}

struct ScaleTypeButtons_Previews: PreviewProvider {
    static var previews: some View {
        ScaleTypeButtons().environmentObject(DrawSettings())
    }
}
