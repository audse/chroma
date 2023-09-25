//
//  LineToolButton.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

struct LineToolButton: View {
    @EnvironmentObject var drawSettings: DrawSettings
    @EnvironmentObject var history: History

    var body: some View {
        Button {
            history.add(SelectToolAction(.line, drawSettings))
        } label: {
            LineToolIcon.getView()
        }
        .active(drawSettings.tool == .line)
        .help("Line Tool")
        .keyboardShortcut("l", modifiers: [])
    }
}
