//
//  AppSettingsModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

enum AppColorScheme: Codable {
    case followSystem
    case custom(ColorScheme)

    static func == (lhs: AppColorScheme, rhs: AppColorScheme) -> Bool {
        switch (lhs, rhs) {
        case (let .custom(lhs), let .custom(rhs)): return lhs == rhs
        case (.followSystem, .followSystem): return true
        default: return false
        }
    }
}

class AppSettingsModel: ObservableObject {
    @Published var colorScheme: AppColorScheme = .followSystem {
        didSet { save() }
    }
    @Published var showingSettings: Bool = false
    @Published var showingImport: Bool = false
    @Published var showingExport: Bool = false
    
    init() {
        self.colorScheme = getSavedProperty(key: "colorScheme", defaultValue: AppColorScheme.followSystem)
    }
    
    func save() {
        saveProperty(key: "colorScheme", value: colorScheme)
    }

    var colorSchemeValue: ColorScheme {
        switch colorScheme {
        case .custom(let value): return value
        case .followSystem: return .dark // TODO
        }
    }

    var isDark: Bool {
        return colorScheme == .custom(.dark)
    }

    var isLight: Bool {
        return colorScheme == .custom(.light)
    }
}

private struct AppSettingsModelKey: EnvironmentKey {
    static var defaultValue = AppSettingsModel()
}

extension EnvironmentValues {
    var appSettings: AppSettingsModel {
        get { self[AppSettingsModelKey.self] }
        set { self[AppSettingsModelKey.self] = newValue }
    }
}
