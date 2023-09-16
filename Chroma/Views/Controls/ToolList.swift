//
//  Tools.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct ToolList: View {
    @EnvironmentObject var drawSettings: DrawSettings
    
    var body: some View {
        VStack {
            Button {
                drawSettings.tool = Tool.draw
            } label: {
                Image(systemName: "paintbrush.fill")
            }
            .tint(drawSettings.tool == Tool.draw ? Color.accentColor : Color.primary)
            .help("Draw Tool")
            Button {
                drawSettings.tool = Tool.erase
            } label: {
                Image(systemName: "eraser.fill")
            }
            .tint(drawSettings.tool == Tool.erase ? Color.accentColor : Color.primary)
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
