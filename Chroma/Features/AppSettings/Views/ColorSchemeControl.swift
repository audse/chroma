//
//  ColorSchemeControl.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

struct ColorSchemeControl: View {
    @EnvironmentObject var appSettings: AppSettingsModel

    @State private var isFollowingSystem: Bool = false
    @State private var isDarkMode: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Color scheme")
                .font(.label)
                .foregroundColor(.secondary)

            HStack {
                Toggle("Follow system", isOn: $isFollowingSystem)
                    .onChange(of: isFollowingSystem) { newValue in
                        switch newValue {
                        case true: appSettings.colorScheme = .followSystem
                        case false: appSettings.colorScheme = .custom(isDarkMode ? .dark : .light)
                        }
                    }
                Spacer()
                Toggle("Dark mode", isOn: $isDarkMode)
                    .toggleStyle(.switch)
                    .disabled(isFollowingSystem)
                    .opacity(isFollowingSystem ? 0.25 : 1.0)
                    .onChange(of: isDarkMode) { newValue in
                        appSettings.colorScheme = .custom(newValue ? .dark : .light)
                    }
            }
        }.onAppear {
            isFollowingSystem = appSettings.colorScheme == .followSystem
            isDarkMode = appSettings.isDark
        }
    }
}

struct ColorSchemeControl_Previews: PreviewProvider {
    static var previews: some View {
        ColorSchemeControl()
            .environmentObject(AppSettingsModel())
    }
}
