//
//  LayerFilterList.swift
//  Chroma
//
//  Created by Audrey Serene on 9/28/23.
//

import SwiftUI

struct LayerFilterList: View {
    @EnvironmentObject var history: History
    @ObservedObject var layer: LayerModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Filters")
                Spacer()
                Button {
                    history.add(AddFilterAction(.blur(.init(radius: 0)), layer))
                } label: {
                    Label("Blur", systemImage: "plus")
                }
                Button {
                    history.add(AddFilterAction(
                        .shadow(.init(
                            offset: CGPoint(),
                            radius: 0,
                            color: .black.opacity(0.25)
                        )),
                        layer
                    ))
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
                                history.addOrAccumulate(ChangeFilterAction(.blur($0), layer))
                            }
                        )
                        LayerBlurFilter(
                            filter: binding,
                            onRemove: { _ in
                                history.add(RemoveFilterAction(filter, layer))
                            }
                        )
                    case .shadow(var shadow):
                        let binding = Binding(
                            get: { shadow },
                            set: {
                                history.addOrAccumulate(ChangeFilterAction(.shadow($0), layer))
                            }
                        )
                        LayerShadowFilter(
                            filter: binding,
                            onRemove: { _ in
                                history.add(RemoveFilterAction(filter, layer))
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
