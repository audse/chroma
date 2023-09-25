//
//  EraseToolButton.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

struct EraseToolButton: View {
    @EnvironmentObject var drawSettings: DrawSettings
    @EnvironmentObject var history: History

    var body: some View {
        Button {
            history.add(SelectToolAction(.erase, drawSettings))
        } label: {
            Image(systemName: "eraser.fill")
                .frame(width: 14)
        }
        .active(drawSettings.tool == .erase)
        .help("Erase Tool")
        .keyboardShortcut("e", modifiers: [])
    }
}
