//
//  BackgroundColorControl.swift
//  Chroma
//
//  Created by Audrey Serene on 9/16/23.
//

import SwiftUI

struct BackgroundColorControl: View {
    @Environment(\.canvasBgColor) var canvasBgColor
    
    @State var color = Color.white
    
    var body: some View {
        ColorPicker("Background", selection: $color)
            .labelsHidden()
            .onChange(of: color) { color in
                print("Changed bg color!")
                canvasBgColor.wrappedValue = color
            }
    }
}

struct BackgroundColorControl_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundColorControl()
    }
}
