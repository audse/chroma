//
//  ExportType.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import Foundation

enum ExportType: Equatable {
    case png
    
    var name: String {
        switch self {
        case .png: return "PNG"
        }
    }
}
