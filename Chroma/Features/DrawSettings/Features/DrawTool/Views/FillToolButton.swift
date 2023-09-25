//
//  FillToolButton.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

struct FillToolButton: View {
    @EnvironmentObject var drawSettings: DrawSettings
    @EnvironmentObject var history: History

    var body: some View {
        Button {
            history.add(SelectToolAction(.fill, drawSettings))
        } label: {
            Image(systemName: "drop.fill")
                .frame(width: 14)
        }
        .active(drawSettings.tool == .fill)
        .help("Fill Tool")
        .keyboardShortcut("f", modifiers: [])
    }
}
