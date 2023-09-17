//
//  ViewSettingsPanel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/15/23.
//

import SwiftUI

struct ViewSettingsPanel: View {
    @State var isExpanded: Bool = true
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded.animation(.easeInOut(duration: 0.2))) {
            VStack {
                PrecisionControl().expandWidth(alignment: .leading)
                TileModeButtons()
                GridModeButtons()
            }
        } label: {
            HStack { Text("View").expandWidth() }
                .background(Color.almostClear)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isExpanded = !isExpanded
                    }
                }
        }.frame(width: 200)
        .panel()
    }
}

struct ViewSettingsPanel_Previews: PreviewProvider {
    static var previews: some View {
        ViewSettingsPanel()
            .environmentObject(DrawSettings())
    }
}
