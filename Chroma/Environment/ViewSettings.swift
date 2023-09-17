//
//  ViewSettings.swift
//  Chroma
//
//  Created by Audrey Serene on 9/13/23.
//

import SwiftUI

private struct ZoomKey: EnvironmentKey {
    static var defaultValue: Binding<CGFloat> = .constant(1.0)
}

enum TileMode {
    case horizontal
    case vertical
    case both
    case none
}

private struct TileModeKey: EnvironmentKey {
    static var defaultValue: Binding<TileMode> = .constant(TileMode.none)
}

enum GridMode {
    case dots
    case lines
    case none
}

private struct GridModeKey: EnvironmentKey {
    static var defaultValue: Binding<GridMode> = .constant(.dots)
}

extension EnvironmentValues {
    var zoom: Binding<CGFloat> {
        get { self[ZoomKey.self] }
        set { self[ZoomKey.self] = newValue }
    }
    var tileMode: Binding<TileMode> {
        get { self[TileModeKey.self] }
        set { self[TileModeKey.self] = newValue }
    }
    var gridMode: Binding<GridMode> {
        get { self[GridModeKey.self] }
        set { self[GridModeKey.self] = newValue }
    }
}
