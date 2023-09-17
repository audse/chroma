//
//  AppSettings.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

struct AppSettings: View {
    @EnvironmentObject var appSettings: AppSettingsModel
    
    @Binding var showing: Bool
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                Text("Settings").font(.title)
                
                ColorSchemeControl()
                
                Spacer(minLength: 12)
                Text("Workspace").font(.title2)
                
                WorkspaceBackgroundColorControl()
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Grid mode").font(.label).foregroundColor(.secondary)
                    GridModeButtons()
                        .frame(width: 130)
                        .fixedSize()
                }
                
                Spacer(minLength: 24)
                Divider()
                
                HStack {
                    Button {
                        showing = false
                    } label: {
                        Text("Done").fontWeight(.semibold)
                    }
                    .composableButtonStyle(
                        Btn.defaultPadding
                        |> Btn.hStack
                        |> Btn.filledAccent
                        |> Btn.rounded
                        |> Btn.scaled
                    )
                }
            }
            .padding(EdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24))
            .frame(minWidth: 600, minHeight: 400)
        }
    }
}

struct AppSettings_Previews: PreviewProvider {
    static var previews: some View {
        AppSettings(showing: .constant(true))
            .environmentObject(AppSettingsModel())
            .environmentObject(WorkspaceSettingsModel())
    }
}
