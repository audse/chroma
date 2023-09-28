//
//  PalettePicker.swift
//  Chroma
//
//  Created by Audrey Serene on 9/27/23.
//

import SwiftUI

struct PalettePicker: View {
    @State var palette: PaletteModel
    @Binding var color: Color
    var numColumns: Int = 6
    
    var body: some View {
        let columns = (0..<numColumns).map { _ in
            GridItem(spacing: 10)
        }
        VStack(alignment: .leading, spacing: 2) {
            Text(palette.name)
                .font(.label)
                .foregroundColor(.primary.lerp(.secondary, by: 0.5))
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(palette.colors, id: \.hex) { paletteColor in
                    let rect = RoundedRectangle(cornerRadius: 4)
                    Button {
                        color = paletteColor
                    } label: { rect.fill(paletteColor) }
                    .buttonStyle(.plain)
                    .if(color == paletteColor) { view in
                        view.overlay(
                            rect.stroke(.primary, lineWidth: 3)
                        )
                    }
                    .frame(width: 16, height: 16)
                }
            }
        }.fixedSize()
    }
}

#Preview {
    PalettePicker(
        palette: PaletteModel(
            name: "My palette",
            colors: [
                .black,
                .gray,
                .white,
                .red,
                .orange,
                .yellow,
                .green,
                .blue,
                .purple
            ]
        ),
        color: .constant(.red),
        numColumns: 6
    ).padding()
}
