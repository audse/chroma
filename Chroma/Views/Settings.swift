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
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Settings").font(.title)
                
                Toggle(isOn: $isDarkMode, label: {
                    Text("Dark mode")
                }).toggleStyle(.switch)
                
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
                        |> Btn.rounded
                        |> Btn.scaled
                        |> Btn.filledAccent
                    )
                }
            }
            .padding(EdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24))
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(showing: .constant(true), isDarkMode: .constant(true))
    }
}
