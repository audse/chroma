//
//  Rotations.swift
//  Chroma
//
//  Created by Audrey Serene on 9/12/23.
//

import SwiftUI

struct RotationControl: View {
    @EnvironmentObject var drawSettings: DrawSettings

    var body: some View {
        HStack {
            Button {
                drawSettings.rotation -= Angle(degrees: 90)
            } label: {
                Image(systemName: "rotate.left.fill")
            }
            .help("Rotate Left")
            .keyboardShortcut(",", modifiers: [])
            Button {
                drawSettings.rotation += Angle(degrees: 90)
            } label: {
                Image(systemName: "rotate.right.fill")
            }
            .help("Rotate Right")
            .keyboardShortcut(".", modifiers: [])
        }.labelStyle(.iconOnly)
            .active(false)
    }
}

struct RotationControl_Previews: PreviewProvider {
    static var previews: some View {
        RotationControl().environmentObject(DrawSettings())
    }
}
