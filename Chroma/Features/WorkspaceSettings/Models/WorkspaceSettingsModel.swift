//
//  WorkspaceSettingsModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

class WorkspaceSettingsModel: ObservableObject {
    @Published var gridMode: GridMode = .dots
    @Published var backgroundColor: WorkspaceBackgroundColor = .followColorScheme
    @Published var tileMode: TileMode = .none
    @Published var zoom: CGFloat = 1.0
}

private struct WorkspaceSettingsModelKey: EnvironmentKey {
    static var defaultValue = WorkspaceSettingsModel()
}

extension EnvironmentValues {
    var workspaceSettings: WorkspaceSettingsModel {
        get { self[WorkspaceSettingsModelKey.self] }
        set { self[WorkspaceSettingsModelKey.self] = newValue }
    }
}
