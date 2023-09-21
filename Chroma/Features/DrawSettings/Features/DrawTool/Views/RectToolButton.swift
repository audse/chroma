//
//  RectToolButton.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

struct RectToolButton: View {
    @EnvironmentObject var drawSettings: DrawSettings
    
    var body: some View {
        Button {
            drawSettings.setTool(.rect)
        } label: {
            RectToolIcon.getView()
        }
        .active(drawSettings.tool == .rect)
        .help("Rectangle Tool")
        .keyboardShortcut("r", modifiers: [])
    }
}
