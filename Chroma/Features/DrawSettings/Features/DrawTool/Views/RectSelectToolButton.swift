//
//  RectSelectToolButton.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

struct RectSelectToolButton: View {
    @EnvironmentObject var drawSettings: DrawSettings

    var body: some View {
        Button {
            drawSettings.setTool(.rectSelect)
        } label: {
            Image(systemName: "square.dashed")
        }
        .active(drawSettings.tool == .rectSelect)
        .help("Rectangle Select Tool")
        .keyboardShortcut("s", modifiers: [])
    }
}
