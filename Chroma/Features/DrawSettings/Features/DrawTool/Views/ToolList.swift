//
//  Tools.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct ToolList: View {
    @EnvironmentObject var drawSettings: DrawSettings
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Button {
                drawSettings.tool = .draw
            } label: {
                Image(systemName: "paintbrush.fill")
                    .frame(width: 14)
            }
            .active(drawSettings.tool == .draw)
            .help("Draw Tool")
            .keyboardShortcut("p", modifiers: [])
            
            Button {
                drawSettings.tool = .erase
            } label: {
                Image(systemName: "eraser.fill")
                    .frame(width: 14)
            }
            .active(drawSettings.tool == .erase)
            .help("Erase Tool")
            .keyboardShortcut("e", modifiers: [])
            
            Button {
                drawSettings.tool = .fill
            } label: {
                Image(systemName: "drop.fill")
                    .frame(width: 14)
            }
            .active(drawSettings.tool == .fill)
            .help("Fill Tool")
            .keyboardShortcut("f", modifiers: [])
        }
        .labelStyle(.iconOnly)
    }
}

struct ToolList_Previews: PreviewProvider {
    static var previews: some View {
        ToolList().environmentObject(DrawSettings())
    }
}
