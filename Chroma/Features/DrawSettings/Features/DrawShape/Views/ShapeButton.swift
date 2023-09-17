//
//  ShapeButton.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct ShapeButton: View {
    @EnvironmentObject private var drawSettings: DrawSettings
    
    @State var shape: DrawShape
    
    var body: some View {
        Button {
            drawSettings.shape = shape
        } label: {
            shape.shape
                .fill(drawSettings.shape.id == shape.id ? Color.accentColor : Color.secondary)
                .rotationEffect(drawSettings.rotation)
                .frame(width: 50, height: 50)
                .animation(.easeInOut(duration: 0.3), value: drawSettings.rotation)
        }.buttonStyle(.plain)
            .background(Color.almostClear)
            .frame(width: 50, height: 50)
            .help(shape.id)
            
    }
}

struct ShapeButton_Previews: PreviewProvider {
    static var previews: some View {
        ShapeButton(shape: QuadrantShape)
            .environmentObject(DrawSettings())
    }
}
