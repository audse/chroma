//
//  ExportSettings.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI

enum ExportType {
    case png
}

class ExportSettingsModel: ObservableObject {
    @Published var url: URL?
    @Published var type: ExportType = .png
}

private struct ExportSettingsKey: EnvironmentKey {
    static var defaultValue = ExportSettingsModel()
}

extension EnvironmentValues {
    var exportSettings: ExportSettingsModel {
        get { self[ExportSettingsKey.self] }
        set { self[ExportSettingsKey.self] = newValue }
    }
}
