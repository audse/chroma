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
                TileModeButtons()
                GridModeButtons()
            }
        } label: {
            HStack {
                Text("View")
                    .expandWidth()
            }
            .background(Color(white: 1, opacity: 0.001))
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isExpanded = !isExpanded
                }
            }
        }.frame(width: 150)
        .panel()
    }
}

struct ViewSettingsPanel_Previews: PreviewProvider {
    static var previews: some View {
        ViewSettingsPanel()
    }
}
