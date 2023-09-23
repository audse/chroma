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
            drawSettings.setTool(.drawPositive)
        } label: {
            Image(systemName: "paintbrush.fill")
                .frame(width: 14)
        }
        .active([.drawPositive, .drawNegative].contains(drawSettings.tool))
        .help("Draw Tool")
        .keyboardShortcut("p", modifiers: [])
    }
}
