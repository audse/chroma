//
//  MoveToolButton.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

struct MoveToolButton: View {
    @EnvironmentObject var drawSettings: DrawSettings
    @EnvironmentObject var history: History

    var body: some View {
        Button {
            history.add(SelectToolAction(.move, drawSettings))
        } label: {
            Image(systemName: "hand.point.up.left.fill")
        }
        .active(drawSettings.tool == .move)
        .help("Move Tool")
        .keyboardShortcut("m")
    }
}
