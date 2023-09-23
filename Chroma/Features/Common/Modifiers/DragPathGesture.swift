//
//  DragPathGesture.swift
//  Chroma
//
//  Created by Audrey Serene on 9/23/23.
//

import SwiftUI

public enum DragPathState: Equatable {
    case inactive
    case dragging([CGPoint])
    
    var points: [CGPoint] {
        switch self {
        case .dragging(let points): return points
        default: return []
        }
    }
    
    var last: CGPoint {
        return points.last ?? CGPoint()
    }
    
    var first: CGPoint {
        return points.first ?? CGPoint()
    }
    
    var delta: CGSize {
        let first = self.first, last = self.last
        return CGSize(
            width: last.x - first.x,
            height: last.y - first.y
        )
    }
    
    mutating func onDragChanged(_ value: DragGesture.Value) {
        switch self {
        case .inactive: self = .dragging([value.location])
        case .dragging(var points):
            points.append(value.location)
            self = .dragging(points)
        }
    }
    
    mutating func onDragEnded(_ value: DragGesture.Value) {
        self = .inactive
    }
}

public struct DragPathGestureModifier: ViewModifier {
    public typealias Callback = (DragPathState) -> Void
    public typealias StatelessCallback = () -> Void
    
    @Binding var state: DragPathState
    
    @State public var minimumDistance: CGFloat?
    /** Called BEFORE `state` is set to `dragging` */
    @State public var onBeforeStarted: StatelessCallback?
    /** Called AFTER `state` is set to `dragging` */
    @State public var onAfterStarted: Callback?
    /** Called AFTER start. Will not be run on the first frame. */
    @State public var onChanged: Callback?
    /** Called BEFORE `state` is set to `inactive` */
    @State public var onBeforeEnded: Callback?
    /** Called AFTER `state` is set to `inactive` */
    @State public var onAfterEnded: StatelessCallback?
    
    public func body(content: Content) -> some View {
        content.gesture(makeGesture())
    }
    
    internal func makeGesture() -> some Gesture {
        DragGesture(minimumDistance: minimumDistance ?? 5)
            .onChanged { value in
                let isStarted = state == .inactive
                if let onBeforeStarted {
                    onBeforeStarted()
                }
                if !isStarted, let onChanged {
                    onChanged(state)
                }
                state.onDragChanged(value)
                if isStarted, let onAfterStarted {
                    onAfterStarted(state)
                }
            }
            .onEnded { value in
                if let onBeforeEnded {
                    onBeforeEnded(state)
                }
                state.onDragEnded(value)
                if let onAfterEnded {
                    onAfterEnded()
                }
            }
    }
}

extension View {
    public func dragPathGesture(
        state: Binding<DragPathState>,
        minimumDistance: CGFloat? = nil,
        onBeforeStarted: DragPathGestureModifier.StatelessCallback? = nil,
        onAfterStarted: DragPathGestureModifier.Callback? = nil,
        onChanged: DragPathGestureModifier.Callback? = nil,
        onBeforeEnded: DragPathGestureModifier.Callback? = nil,
        onAfterEnded: DragPathGestureModifier.StatelessCallback? = nil
    ) -> some View {
        modifier(DragPathGestureModifier(
            state: state,
            minimumDistance: minimumDistance,
            onBeforeStarted: onBeforeStarted,
            onAfterStarted: onAfterStarted,
            onChanged: onChanged,
            onBeforeEnded: onBeforeEnded,
            onAfterEnded: onAfterEnded
        ))
    }
}
