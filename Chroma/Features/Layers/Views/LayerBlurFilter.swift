//
//  LayerBlurFilter.swift
//  Chroma
//
//  Created by Audrey Serene on 9/28/23.
//

import SwiftUI

struct LayerBlurFilter: View {
    @Binding var filter: LayerFilter.Blur
    var onRemove: ((LayerFilter.Blur) -> Void)?
    
    var body: some View {
        HStack {
            Text("Blur")
            Spacer()
            NumberTextField(
                value: $filter.radius,
                min: 0
            ).frame(width: 50).fixedSize()
            Button {
                if let onRemove {
                    onRemove(filter)
                }
            } label: {
                Image(systemName: "trash.fill")
            }
        }
    }
}

#Preview {
    LayerBlurFilter(
        filter: .constant(.init(radius: 3))
    )
}
