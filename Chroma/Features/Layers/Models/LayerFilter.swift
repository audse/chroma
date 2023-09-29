//
//  LayerFilter.swift
//  Chroma
//
//  Created by Audrey Serene on 9/28/23.
//

import SwiftUI

public enum LayerFilter: Codable, Equatable {
    case blur(Self.Blur)
    case shadow(Self.Shadow)
    
    public struct Blur: Codable, Equatable, Identifiable {
        public var id = UUID()
        public var radius: Double
    }
    
    public struct Shadow: Codable, Equatable, Identifiable {
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
