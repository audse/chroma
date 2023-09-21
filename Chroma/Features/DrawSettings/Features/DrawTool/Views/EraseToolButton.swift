//
//  EraseToolButton.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

struct EraseToolButton: View {
    @EnvironmentObject var drawSettings: DrawSettings

    var body: some View {
        Button {
            drawSettings.setTool(.erase)
        } label: {
            Image(systemName: "eraser.fill")
                .frame(width: 14)
        }
        .active(drawSettings.tool == .erase)
        .help("Erase Tool")
        .keyboardShortcut("e", modifiers: [])
    }
}
