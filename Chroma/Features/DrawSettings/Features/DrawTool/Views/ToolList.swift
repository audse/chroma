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
        VStack(spacing: 4) {
            DrawToolButton()
            EraseToolButton()
            FillToolButton()
            LineToolButton()
            RectToolButton()
        }
    }
}

struct ToolList_Previews: PreviewProvider {
    static var previews: some View {
        ToolList().environmentObject(DrawSettings())
    }
}
