//
//  LayerFilterList.swift
//  Chroma
//
//  Created by Audrey Serene on 9/28/23.
//

import SwiftUI

struct LayerFilterList: View {
    @ObservedObject var layer: LayerModel
    var body: some View {
        VStack {
            HStack {
                Text("Filters")
                Spacer()
                Button {
                    layer.filters.append(.blur(.init(radius: 0)))
                } label: {
                    Label("Blur", systemImage: "plus")
                }
                Button {
                    layer.filters.append(.shadow(.init(
                        offset: CGPoint(),
                        radius: 0,
                        color: .black.opacity(0.25)
                    )))
                } label: {
                    Label("Shadow", systemImage: "plus")
                }
            }
            VStack(spacing: 4) {
                ForEach(Array(layer.filters.enumerated()), id: \.0) { (index, filter) in
                    switch filter {
                    case .blur(var blur):
                        let binding = Binding(
                            get: { blur },
                            set: {
                                blur = $0
                                layer.filters[index] = .blur($0)
                            }
                        )
                        LayerBlurFilter(
                            filter: binding,
                            onRemove: { _ in
                                layer.filters.remove(at: index)
                            }
                        )
                    case .shadow(var shadow):
                        let binding = Binding(
                            get: { shadow },
                            set: {
                                shadow = $0
                                layer.filters[index] = .shadow($0)
                            }
                        )
                        LayerShadowFilter(
                            filter: binding,
                            onRemove: { _ in
                                layer.filters.remove(at: index)
                            }
                        )
                    }
                }
            }
        }.well().padding(6)
    }
}

#Preview {
    LayerFilterList(
        layer: LayerModel(
            filters: [
                .blur(.init(radius: 3)),
                .shadow(.init(
                    offset: CGPoint(x: 0, y: 1),
                    radius: 2,
                    color: .black.opacity(0.25)
                ))
            ]
        )
    )
}
