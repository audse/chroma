//
//  Settings.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

struct Settings: View {
    @Binding var showing: Bool
    @Binding var isDarkMode: Bool
    @Binding var workspaceBgColor: WorkspaceBgColor
    
    @State var useCustomColor: Bool = false
    @State var customColor: Color = .black
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Settings").font(.title)
                
                Toggle("Dark mode", isOn: $isDarkMode).toggleStyle(.switch)
                
                Text("Workspace background color")
                HStack {
                    Toggle(
                        "Use custom color",
                        isOn: $useCustomColor
                    ).onChange(of: useCustomColor) { value in
                        workspaceBgColor = .custom(customColor)
                    }
                    Spacer()
                    ColorPicker("Custom color", selection: $customColor).onChange(of: customColor) { newValue in
                        workspaceBgColor = .custom(customColor)
                    }.disabled(workspaceBgColor == .followColorScheme)
                        .opacity(workspaceBgColor == .followColorScheme ? 0.5 : 1.0)
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
            .onAppear {
                if case .custom(let color) = workspaceBgColor {
                    customColor = color
                    useCustomColor = true
                }
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(
            showing: .constant(true),
            isDarkMode: .constant(true),
            workspaceBgColor: .constant(.followColorScheme)
        )
    }
}
