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
            ColorPicker("Grid color", selection: $workspaceSettings.gridColor)
                .labelsHidden()
        }
    }
}

struct WorkspaceGridColorControl_Previews: PreviewProvider {
    static var previews: some View {
        WorkspaceGridColorControl()
            .environmentObject(WorkspaceSettingsModel())
    }
}
