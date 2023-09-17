//
//  ZoomGesture.swift
//  Chroma
//
//  Created by Audrey Serene on 9/13/23.
//

import SwiftUI

struct ZoomGestureModifier: ViewModifier {
    @Binding var totalZoom: CGFloat
    var onChanged: ((_: CGFloat) -> Void)? = nil
    @State private var currentZoom = 0.0
    
    func body(content: Content) -> some View {
        content
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        currentZoom = value.magnitude - 1
                    }
                    .onEnded { value in
                        totalZoom += currentZoom
                        if totalZoom < 0.1 { totalZoom = 0.1 }
                        currentZoom = 0
                        if case Optional.some(let callback) = onChanged {
                            callback(totalZoom)
                        }
                    }
            )
    }
}

extension View {
    func zoomable(zoom: Binding<CGFloat>, onChanged: ((_: CGFloat) -> Void)? = nil) -> some View {
        modifier(ZoomGestureModifier(totalZoom: zoom, onChanged: onChanged))
    }
}
