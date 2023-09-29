//
//  LayerShadowFilter.swift
//  Chroma
//
//  Created by Audrey Serene on 9/28/23.
//

import SwiftUI

struct LayerShadowFilter: View {
    @Binding var filter: LayerFilter.Shadow
    
    var onRemove: ((LayerFilter.Shadow) -> Void)?
    
    var body: some View {
        let xBinding = Binding(
            get: { Double(filter.offset.x) },
            set: { filter.offset.x = $0 }
        )
        let yBinding = Binding(
            get: { Double(filter.offset.y) },
            set: { filter.offset.y = $0 }
        )
        HStack(spacing: 4) {
            Text("Shadow")
            
            Spacer()
            
            Text("X")
                .font(.label)
                .foregroundColor(.primary.lerp(.secondary))
            NumberTextField(
                value: xBinding,
                min: 0
            ).frame(width: 50).fixedSize()
            
            Text("Y")
                .font(.label)
                .foregroundColor(.primary.lerp(.secondary))
            NumberTextField(
                value: yBinding,
                min: 0
            ).frame(width: 50).fixedSize()
            
            Spacer(minLength: 12).fixedSize()
            
            Text("Blur")
                .font(.label)
                .foregroundColor(.primary.lerp(.secondary))
            NumberTextField(
                value: $filter.radius,
                min: 0
            ).frame(width: 50).fixedSize()
            
            Spacer(minLength: 12).fixedSize()
            
            Text("Color")
                .font(.label)
                .foregroundColor(.primary.lerp(.secondary))
            PopoverColorControl(
                color: $filter.color,
                edge: .bottom
            )
            Button {
                if let onRemove {
                    onRemove(filter)
                }
            } label: {
                Image(systemName: "trash.fill")
            }
        }
        .frame(minWidth: 450)
    }
}

#Preview {
    LayerShadowFilter(
        filter: .constant(.init(
            offset: CGPoint(x: 1, y: 2),
            radius: 3.5,
            color: .black.opacity(0.25)
        ))
    )
}
