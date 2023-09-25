//
//  LassoSelectToolButton.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

struct LassoSelectToolButton: View {
    @EnvironmentObject var drawSettings: DrawSettings
    @EnvironmentObject var history: History

    var body: some View {
        Button {
            history.add(SelectToolAction(.lassoSelect, drawSettings))
        } label: {
            Image(systemName: "lasso")
        }
        .active(drawSettings.tool == .lassoSelect)
        .help("Lasso Select Tool")
        .keyboardShortcut("s", modifiers: [.shift])
    }
}
