//
//  LayerFilter.swift
//  Chroma
//
//  Created by Audrey Serene on 9/28/23.
//

import SwiftUI

public enum LayerFilter: Codable {
    case blur(Self.Blur)
    case shadow(Self.Shadow)
    
    public struct Blur: Codable, Identifiable {
        public var id = UUID()
        public var radius: Double
    }
    
    public struct Shadow: Codable, Identifiable {
        public var id = UUID()
        public var offset: CGPoint
        public var radius: Double
        public var color: Color
    }
}

extension LayerFilter: Identifiable {
    public var id: UUID {
        switch self {
        case .blur(let filter): filter.id
        case .shadow(let filter): filter.id
        }
    }
}

extension LayerFilter.Blur: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

extension LayerFilter.Shadow: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

extension LayerFilter: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
