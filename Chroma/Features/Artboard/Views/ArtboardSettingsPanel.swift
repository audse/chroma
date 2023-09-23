//
//  ArtboardSettingsPanel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/16/23.
//

import SwiftUI

struct ArtboardSettingsPanel: View {
    @State var isExpanded: Bool = true

    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded.animation(.easeInOut(duration: 0.2))) {
            VStack {
                ArtboardSizeControl()
                HStack {
                    Text("Background")
                        .font(.label)
                        .foregroundColor(.secondary.lerp(.primary))
                    Spacer()
                    ArtboardBackgroundColorControl()
                }
                LayerList()
            }.padding(Edge.Set.top, 8)
        } label: {
            Text("Artboard").expandWidth()
                .foregroundColor(.primary)
                .background(Color.almostClear)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isExpanded = !isExpanded
                    }
                }
        }.frame(width: 250)
        .panel()
    }
}

struct ArtboardSettingsPanel_Previews: PreviewProvider {
    static let artboard = ArtboardModel().withNewLayer().withNewLayer()
    static var previews: some View {
        ArtboardSettingsPanel()
            .environmentObject(FileModel(artboard: artboard))
            .environmentObject(History().history([
                SelectLayerAction(artboard.layers.first.unsafelyUnwrapped)
            ]))
    }
}
