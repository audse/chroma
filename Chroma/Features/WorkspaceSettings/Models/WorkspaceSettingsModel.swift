//
//  WorkspaceSettingsModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

class WorkspaceSettingsModel: ObservableObject {
    @Published var gridMode: GridMode = .dots {
        didSet { saveProperty(key: "gridMode", value: gridMode) }
    }
    @Published var gridColor: Color = .gray.opacity(0.2) {
        didSet { saveProperty(key: "gridColor", value: gridColor) }
    }
    @Published var gridThickness: Double = 1.0 {
        didSet { saveProperty(key: "gridThickness", value: gridThickness) }
    }
    @Published var backgroundColor: WorkspaceBackgroundColor = .followColorScheme {
        didSet { saveProperty(key: "workspaceBackgroundColor", value: backgroundColor) }
    }
    @Published var tileMode: TileMode = .none
    @Published var zoom: CGFloat = 1.0
                                   
    init(
        gridMode: GridMode? = nil,
        gridColor: Color? = nil,
        gridThickness: Double? = nil,
        backgroundColor: WorkspaceBackgroundColor? = nil,
        tileMode: TileMode = .none,
        zoom: CGFloat = 1.0
    ) {
        self.gridMode = gridMode ?? getSavedProperty(key: "gridMode", defaultValue: .dots)
        self.gridThickness = gridThickness ?? getSavedProperty(key: "gridThickness", defaultValue: 1.0)
        self.gridColor = gridColor
            ?? getSavedProperty(key: "gridColor", defaultValue: Color.gray.opacity(0.2))
        self.backgroundColor = backgroundColor
            ?? getSavedProperty(key: "workspaceBackgroundColor", defaultValue: .followColorScheme)
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
