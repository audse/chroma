//
//  DocumentationPage.swift
//  Chroma
//
//  Created by Audrey Serene on 9/23/23.
//

import SwiftUI

private struct NavbarItem: Identifiable, Hashable, Equatable {
    let id: String
}

private let navbarItems = [
    NavbarItem(id: "Shortcuts")
]

struct DocumentationPage: View {
    @Binding var showing: Bool
    
    @State private var selection: String?
    
    var body: some View {
        NavigationSplitView {
                Text("Documentation")
                    .expandWidth(alignment: .leading)
                    .padding([.top, .leading])
                    .font(.label)
                    .foregroundColor(.secondary.lerp(.primary))
                List(navbarItems, selection: $selection) { item in
                    Text(item.id)
                }.expandHeight()
        } detail: {
            if let selection, selection == "Shortcuts" {
                ShortcutPage()
                    .expand()
            }
            Spacer()
            Divider()
            Button {
                showing.toggle()
            } label: {
                Text("Done")
            }.active(false)
                .keyboardShortcut(.return, modifiers: [])
                .composableButtonStyle(
                    Btn.defaultPadding
                    |> Btn.filledAccent
                    |> Btn.rounded
                )
                .padding([.trailing, .bottom], 8)
                .expandWidth(alignment: .trailing)
        }
    }
}

#Preview {
    VStack {
        DocumentationPage(
            showing: .constant(true)
        )
    }
}
