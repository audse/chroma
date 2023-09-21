//
//  DrawToolButton.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

struct DrawToolButton: View {
    @EnvironmentObject var drawSettings: DrawSettings
    
    var body: some View {
        Button {
            drawSettings.setTool(.draw)
        } label: {
            Image(systemName: "paintbrush.fill")
                .frame(width: 14)
        }
        .active(drawSettings.tool == .draw)
        .help("Draw Tool")
        .keyboardShortcut("p", modifiers: [])
    }
}
