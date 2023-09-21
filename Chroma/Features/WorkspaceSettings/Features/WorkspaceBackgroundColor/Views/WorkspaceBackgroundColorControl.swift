//
//  WorkspaceBackgroundColorControl.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

struct WorkspaceBackgroundColorControl: View {
    @EnvironmentObject var appSettings: AppSettingsModel
    @EnvironmentObject var workspaceSettings: WorkspaceSettingsModel

    @State var followSystem: Bool = true
    @State var customColor: Color = .black

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Workspace background color")
                .font(.label)
                .foregroundColor(.secondary)
            HStack {
                Toggle(
                    "Follow system color scheme",
                    isOn: $followSystem
                ).onChange(of: followSystem) { value in
                    setColor(value ? nil : customColor)
                }
                Spacer()
                ColorPicker("Custom color", selection: $customColor).onChange(of: customColor) { newValue in
                    setColor(newValue)
                }.disabled(followSystem)
                    .opacity(followSystem ? 0.25 : 1.0)
            }
        }.onAppear {
            followSystem = isFollowingColorScheme()
            switch workspaceSettings.backgroundColor {
            case .followColorScheme: customColor = appSettings.colorSchemeValue == .dark
                ? WorkspaceBackgroundColor.defaultDark
                : WorkspaceBackgroundColor.defaultLight
            case .custom(let color): customColor = color
            }
        }
    }

    func isFollowingColorScheme() -> Bool {
        return workspaceSettings.backgroundColor == .followColorScheme
    }

    func setColor(_ color: Color? = nil) {
        switch color {
        case .some(let value): workspaceSettings.backgroundColor = .custom(value)
        case .none: workspaceSettings.backgroundColor = .followColorScheme
        }
    }
}

struct WorkspaceBackgroundColorControl_Previews: PreviewProvider {
    static var previews: some View {
        WorkspaceBackgroundColorControl()
            .environmentObject(WorkspaceSettingsModel())
            .environmentObject(AppSettingsModel())
    }
}
