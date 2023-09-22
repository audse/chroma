//
//  Path.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

extension Path {
    public func union(_ others: [Path]) -> Path {
        var cgPath = self.cgPath
        others.forEach { other in
            cgPath = cgPath.union(other.cgPath)
        }
        return Path(cgPath)
    }
    
    public func union(_ others: Path...) -> Path {
        union(others)
    }
    
    public func union(_ others: Path..., threshold: CGFloat) -> Path {
        Path(union(others).cgPath.flattened(threshold: threshold))
    }
    
    public func union(_ others: [Path], threshold: CGFloat) -> Path {
        Path(union(others).cgPath.flattened(threshold: threshold))
    }
}
