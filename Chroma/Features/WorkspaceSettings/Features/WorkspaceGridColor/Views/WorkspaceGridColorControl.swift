//
//  WorkspaceGridColorControl.swift
//  Chroma
//
//  Created by Audrey Serene on 9/20/23.
//

import SwiftUI

struct WorkspaceGridColorControl: View {
    @EnvironmentObject var workspaceSettings: WorkspaceSettingsModel

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Grid color")
                .font(.label)
                .foregroundColor(.secondary)
            PopoverColorControl(
                color: $workspaceSettings.gridColor,
                edge: .trailing
            )
        }
    }
}

struct WorkspaceGridColorControl_Previews: PreviewProvider {
    static var previews: some View {
        WorkspaceGridColorControl()
            .environmentObject(WorkspaceSettingsModel())
    }
}
