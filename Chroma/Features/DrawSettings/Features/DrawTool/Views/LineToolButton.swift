//
//  LineToolButton.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

struct LineToolButton: View {
    @EnvironmentObject var drawSettings: DrawSettings
    
    var body: some View {
        Button {
            drawSettings.setTool(.line)
        } label: {
            LineToolIcon.getView()
        }
        .active(drawSettings.tool == .line)
        .help("Line Tool")
        .keyboardShortcut("l", modifiers: [])
    }
}
