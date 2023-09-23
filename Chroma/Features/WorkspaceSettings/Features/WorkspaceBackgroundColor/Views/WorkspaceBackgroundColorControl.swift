//
//  WorkspaceBackgroundColorControl.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

struct WorkspaceBackgroundColorControl: View {
    @Environment(\.colorScheme) var colorScheme
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
                    switch value {
                    case true: workspaceSettings.backgroundColor = .followColorScheme
                    case false: workspaceSettings.backgroundColor = .custom(customColor)
                    }
                }
                Spacer()
                ColorPicker("Custom color", selection: $customColor).onChange(of: customColor) { newValue in
                    if !isFollowingColorScheme() {
                        workspaceSettings.backgroundColor = .custom(newValue)
                    }
                }.disabled(followSystem)
                    .opacity(followSystem ? 0.25 : 1.0)
            }
        }.onAppear {
            followSystem = isFollowingColorScheme()
            switch workspaceSettings.backgroundColor {
            case .followColorScheme: customColor = colorScheme == .dark 
                ? WorkspaceBackgroundColor.defaultDark
                : WorkspaceBackgroundColor.defaultLight
            case .custom(let color): customColor = color
            }
        }
    }

    func isFollowingColorScheme() -> Bool {
        return workspaceSettings.backgroundColor == .followColorScheme
    }
}

#Preview {
    WorkspaceBackgroundColorControl()
        .environmentObject(WorkspaceSettingsModel())
        .environmentObject(AppSettingsModel())
}
