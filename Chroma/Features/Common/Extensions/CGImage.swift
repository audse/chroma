//
//  CGImage.swift
//  Chroma
//
//  Created by Audrey Serene on 9/25/23.
//

import SwiftUI

extension CGImage {
    func getPixelColor(at pos: CGPoint) -> Color? {
        if let dataProvider, let pixelData = dataProvider.data {
            let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
            let pixelInfo: Int = ((Int(self.width) * Int(pos.y)) + Int(pos.x)) * 4
            let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
            let g = CGFloat(data[pixelInfo + 1]) / CGFloat(255.0)
            let b = CGFloat(data[pixelInfo + 2]) / CGFloat(255.0)
            let o = CGFloat(data[pixelInfo + 3]) / CGFloat(255.0)
            return Color(red: r, green: g, blue: b, opacity: o)
      }
      return nil
  }
}
