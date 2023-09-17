//
//  WorkspaceSettingsPanel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/15/23.
//

import SwiftUI

struct WorkspaceSettingsPanel: View {
    @State var isExpanded: Bool = true
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded.animation(.easeInOut(duration: 0.2))) {
            VStack {
                PrecisionControl().expandWidth(alignment: .leading)
                TileModeButtons()
            }
        } label: {
            HStack { Text("Workspace").expandWidth() }
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

struct WorkspaceSettingsPanel_Previews: PreviewProvider {
    static var previews: some View {
        WorkspaceSettingsPanel()
            .environmentObject(DrawSettings())
    }
}
