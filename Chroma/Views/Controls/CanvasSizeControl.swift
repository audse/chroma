//
//  CanvasSizeControl.swift
//  Chroma
//
//  Created by Audrey Serene on 9/16/23.
//

import SwiftUI

struct CanvasSizeControl: View {
    @Environment(\.canvasSize) var canvasSize
    
    @State var canvasWidth: CGFloat = 512
    @State var canvasHeight: CGFloat = 512
    
    var body: some View {
        HStack {
            Text("W")
            NumberTextField(
                value: $canvasWidth,
                min: 0,
                step: 1,
                rounded: true,
                onChangeValue: { value in
                    canvasSize.wrappedValue.width = value
                }
            )
            Spacer()
            Text("H")
            NumberTextField(
                value: $canvasHeight,
                min: 0,
                step: 1,
                rounded: true,
                onChangeValue: { value in
                    canvasSize.wrappedValue.height = value
                }
            )
        }
    }
}

struct CanvasSizeControl_Previews: PreviewProvider {
    static var previews: some View {
        CanvasSizeControl()
    }
}
