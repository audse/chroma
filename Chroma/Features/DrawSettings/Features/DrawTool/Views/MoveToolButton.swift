//
//  MoveToolButton.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

struct MoveToolButton: View {
    @EnvironmentObject var drawSettings: DrawSettings

    var body: some View {
        Button {
            drawSettings.setTool(.move)
        } label: {
            Image(systemName: "hand.point.up.left.fill")
        }
        .active(drawSettings.tool == .move)
        .help("Move Tool")
        .keyboardShortcut("m")
    }
}
