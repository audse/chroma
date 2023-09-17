//
//  ZoomButtons.swift
//  Chroma
//
//  Created by Audrey Serene on 9/13/23.
//

import SwiftUI

struct ZoomButtons: View {
    @EnvironmentObject var workspaceSettings: WorkspaceSettingsModel
    
    var body: some View {
        HStack {
            Button { workspaceSettings.zoom -= 0.25 } label: {
                Image(systemName: "minus.magnifyingglass")
            }.help("Zoom Out")
            Button { workspaceSettings.zoom += 0.25 } label: {
                Image(systemName: "plus.magnifyingglass")
            }.help("Zoom In")
        }.active(false)
            .labelStyle(.iconOnly)
    }
}

struct ZoomButtons_Previews: PreviewProvider {
    static var previews: some View {
        ZoomButtons().environmentObject(WorkspaceSettingsModel())
    }
}
