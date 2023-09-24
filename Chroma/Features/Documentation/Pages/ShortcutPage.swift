//
//  ShortcutPage.swift
//  Chroma
//
//  Created by Audrey Serene on 9/23/23.
//

import SwiftUI

struct ShortcutPage: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Shortcuts")
                .font(.title)
                .padding(.top, 8)
            ScrollView {
                ShortcutList(shortcuts: implementedShortcuts)
            }
        }
        .padding()
        .expand()
    }
}

#Preview {
    ShortcutPage()
}
