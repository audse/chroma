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
                drawSettings.tool = Tool.draw
            } label: {
                Image(systemName: "paintbrush.fill")
            }
            .active(drawSettings.tool == Tool.draw)
            .help("Draw Tool")
            Button {
                drawSettings.tool = Tool.erase
            } label: {
                Image(systemName: "eraser.fill")
            }
            .active(drawSettings.tool == Tool.erase)
            .help("Erase Tool")
        }
        .labelStyle(.iconOnly)
    }
}

struct ToolList_Previews: PreviewProvider {
    static var previews: some View {
        ToolList().environmentObject(DrawSettings())
    }
}
