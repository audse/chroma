//
//  RectSelectToolButton.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

struct RectSelectToolButton: View {
    @EnvironmentObject var drawSettings: DrawSettings
    @EnvironmentObject var history: History

    var body: some View {
        Button {
            history.add(SelectToolAction(.rectSelect, drawSettings))
        } label: {
            Image(systemName: "square.dashed")
        }
        .active(drawSettings.tool == .rectSelect)
        .help("Rectangle Select Tool")
        .keyboardShortcut("s", modifiers: [])
    }
}
