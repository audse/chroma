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
        VStack(alignment: .leading, spacing: 4) {
            MoveToolButton()
            DrawToolButton()
            EraseToolButton()
            FillToolButton()
            LineToolButton()
            RectToolButton()
            RectSelectToolButton()
            LassoSelectToolButton()
        }
    }
}

#Preview {
    ToolList().environmentObject(DrawSettings())
}
