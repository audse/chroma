//
//  GridModeButtons.swift
//  Chroma
//
//  Created by Audrey Serene on 9/15/23.
//

import SwiftUI

struct GridModeButtons: View {
    @EnvironmentObject var workspaceSettings: WorkspaceSettingsModel

    var body: some View {
        MenuButton(label: Text(getText()), content: {
            Button("None") {
                workspaceSettings.gridMode = .none
            }
            Button("Dots") {
                workspaceSettings.gridMode = .dots
            }
            Button("Lines") {
                workspaceSettings.gridMode = .lines
            }
        }).active(false)
    }

    func getText() -> String {
        switch workspaceSettings.gridMode {
        case .dots: return "Dots"
        case .lines: return "Lines"
        case .none: return "None"
        }
    }
}

struct GridModeButtons_Previews: PreviewProvider {
    static var previews: some View {
        GridModeButtons().environmentObject(WorkspaceSettingsModel())
    }
}
