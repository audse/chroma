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
        HStack(alignment: .top, spacing: 2) {
            VStack(spacing: 4) {
                MoveToolButton()
                DrawToolButton()
                EraseToolButton()
                FillToolButton()
                LineToolButton()
                RectToolButton()
                RectSelectToolButton()
                LassoSelectToolButton()
            }
            if [.drawPositive, .drawNegative].contains(drawSettings.tool) {
                VStack(spacing: 4) {
                    Button("+") {
                        drawSettings.setTool(.drawPositive)
                    }.active(drawSettings.tool == .drawPositive)
                        .frame(width: 24)
                    Button("-") {
                        drawSettings.setTool(.drawNegative)
                    }.active(drawSettings.tool == .drawNegative)
                        .frame(width: 24)
                }
            }
        }
    }
}

struct ToolList_Previews: PreviewProvider {
    static var previews: some View {
        ToolList().environmentObject(DrawSettings())
    }
}
