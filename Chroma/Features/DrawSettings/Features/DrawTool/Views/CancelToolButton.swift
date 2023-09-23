//
//  CancelToolButton.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

/**
 A hidden button that, when pressed (using escape key), cancels the rect or line that the user is currently drawing.
 */
struct CancelToolButton: View {
    @EnvironmentObject var drawSettings: DrawSettings

    var body: some View {
        Button {
            drawSettings.multiClickState.removeAll()
        } label: {
            Text("Stop drawing \(drawSettings.tool.name)")
        }.keyboardShortcut(.escape, modifiers: [])
            .buttonStyle(.plain)
            .opacity(0)
            .allowsHitTesting(false)
    }
}
