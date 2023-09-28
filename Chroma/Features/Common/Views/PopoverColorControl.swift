//
//  PopoverColorControl.swift
//  Chroma
//
//  Created by Audrey Serene on 9/27/23.
//

import SwiftUI

struct PopoverColorControl: View {
    @Binding var color: Color
    var edge: Edge = .trailing
    var controls = ColorControl.Control.all
    var palettes: [PaletteModel] = []
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            RoundedRectangle(cornerRadius: 6).fill(color)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(.secondary.opacity(0.5), lineWidth: 2)
        )
        .frame(width: 36, height: 24)
        .fixedSize()
        .buttonStyle(.plain)
        .popover(isPresented: $isPresented, arrowEdge: edge) {
            ColorControl(
                color: $color,
                controls: controls,
                palettes: palettes,
                size: 150,
                handleSize: 20
            ).padding()
        }
    }
}

#Preview {
    PopoverColorControl(color: .constant(.white))
}
