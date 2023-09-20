//
//  WorkspaceGridThicknessControl.swift
//  Chroma
//
//  Created by Audrey Serene on 9/20/23.
//

import SwiftUI

struct WorkspaceGridThicknessControl: View {
    @EnvironmentObject var workspaceSettings: WorkspaceSettingsModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Grid thickness")
                .font(.label)
                .foregroundColor(.secondary)
            NumberTextField(
                value: $workspaceSettings.gridThickness,
                min: 0
            ).frame(maxWidth: 100)
        }
    }
}

struct WorkspaceGridThicknessControl_Previews: PreviewProvider {
    static var previews: some View {
        WorkspaceGridThicknessControl()
            .environmentObject(WorkspaceSettingsModel())
    }
}
