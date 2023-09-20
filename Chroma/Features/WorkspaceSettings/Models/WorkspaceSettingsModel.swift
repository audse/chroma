//
//  WorkspaceSettingsModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

class WorkspaceSettingsModel: ObservableObject {
    @Published var gridMode: GridMode = .dots
    @Published var gridColor: Color = .gray.opacity(0.2)
    @Published var gridThickness: Double = 1.0
    @Published var backgroundColor: WorkspaceBackgroundColor = .followColorScheme
    @Published var tileMode: TileMode = .none
    @Published var zoom: CGFloat = 1.0
    
    init(
        gridMode: GridMode = .dots,
        gridColor: Color = .gray.opacity(0.2),
        gridThickness: Double = 1.0,
        backgroundColor: WorkspaceBackgroundColor = .followColorScheme,
        tileMode: TileMode = .none,
        zoom: CGFloat = 1.0
    ) {
        self.gridMode = gridMode
        self.gridColor = gridColor
        self.gridThickness = gridThickness
        self.backgroundColor = backgroundColor
        self.tileMode = tileMode
        self.zoom = zoom
    }
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
