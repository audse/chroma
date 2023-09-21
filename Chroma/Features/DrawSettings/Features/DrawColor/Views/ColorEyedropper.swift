//
//  ColorEyedropper.swift
//  Chroma
//
//  Created by Audrey Serene on 9/20/23.
//

import SwiftUI

struct ColorEyedropper: View {
    @EnvironmentObject var drawSettings: DrawSettings
    
    var body: some View {
        Button {
            drawSettings.tool = .eyedropper
        } label: {
            Image(systemName: "eyedropper.halffull")
        }
        .active(drawSettings.tool == .eyedropper)
        .composableButtonStyle(
            Btn.padding
            |> Btn.filledAccent
            |> Btn.rounded
            |> Btn.scaled
        )
    }
}

struct ColorEyedropper_Previews: PreviewProvider {
    static var previews: some View {
        ColorEyedropper().environmentObject(DrawSettings())
    }
}
