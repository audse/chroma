//
//  RectToolButton.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

struct RectToolButton: View {
    @EnvironmentObject var drawSettings: DrawSettings
    @EnvironmentObject var history: History

    var body: some View {
        Button {
            history.add(SelectToolAction(.rect, drawSettings))
        } label: {
            RectToolIcon.getView()
        }
        .active(drawSettings.tool == .rect)
        .help("Rectangle Tool")
        .keyboardShortcut("r", modifiers: [])
    }
}
