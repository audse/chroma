//
//  ColorPicker.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct ColorControl: View {
    @EnvironmentObject private var drawSettings: DrawSettings
    
    @State var color = Color.black
    
    var body: some View {
        ColorPicker("Color", selection: $color)
            .labelsHidden()
            .onChange(of: color) { color in
                drawSettings.color = color
            }
    }
}

struct ColorControl_Previews: PreviewProvider {
    static var previews: some View {
        ColorControl().environmentObject(DrawSettings())
    }
}
