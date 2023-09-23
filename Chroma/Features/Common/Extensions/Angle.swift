//
//  Angle.swift
//  Chroma
//
//  Created by Audrey Serene on 9/23/23.
//

import SwiftUI

extension Angle: Codable {
    internal enum CodingKeys: CodingKey {
        case degrees
        case radians
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let degrees = try? values.decode(CGFloat.self, forKey: .degrees) {
            self.init(degrees: degrees)
        } else if let radians = try? values.decode(CGFloat.self, forKey: .radians) {
            self.init(radians: radians)
        } else {
            self.init()
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(degrees, forKey: .degrees)
        try container.encode(radians, forKey: .radians)
    }
}
