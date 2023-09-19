//
//  AppSettingsModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

enum AppColorScheme {
    case followSystem
    case custom(ColorScheme)
    
    static func ==(lhs: AppColorScheme, rhs: AppColorScheme) -> Bool {
        switch (lhs, rhs) {
            case (let .custom(a), let .custom(b)): return a == b
            case (.followSystem, .followSystem): return true
            default: return false
        }
    }
}

class AppSettingsModel: ObservableObject {
    @Published var colorScheme: AppColorScheme = .custom(.dark)
    @Published var showingSettings: Bool = false
    
    lazy var showingSettingsBinding: Binding<Bool> = Binding(
        get: { self.showingSettings },
        set: { newValue in self.showingSettings = newValue }
    )
    
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
