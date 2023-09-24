//
//  BooleanShapePage.swift
//  Chroma
//
//  Created by Audrey Serene on 9/24/23.
//

import SwiftUI

private let description = """
Drawing a positive shape **adds** to the artboard.
"""

private let example1pixel1 = PixelModel(
    color: .emerald,
    size: 256,
    position: CGPoint(0)
)
private let example1pixel2 = PixelModel(
    shape: CircleShape,
    color: .red,
    size: 256,
    position: CGPoint(128)
)
private let example1pixel3 = PixelModel(
    color: .emerald,
    size: 256,
    position: CGPoint(256)
)

private let example1layer1 = LayerModel(pixels: [
    example1pixel1.positive(),
    example1pixel2.negative(),
    example1pixel3.positive()
])

private let example1layer2 = LayerModel(pixels: [
    example1pixel1.positive(),
    example1pixel2.positive(),
    example1pixel3.positive()
])

struct BooleanShapePage: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                BooleanShapePage.title
                Divider().frame(minHeight: 12)
                
                BooleanShapePage.description
                
                Divider().frame(minHeight: 24)
                
                Text("Examples")
                    .font(.title2)
                
                Text("This picture was created with the following shapes:")
                    .expandWidth(alignment: .leading)
                    .padding(.bottom, 6)
                
                HStack {
                    VStack {
                        Label("1. Square", systemImage: "plus")
                        Label("2. Circle", systemImage: "minus")
                        Label("3. Square", systemImage: "plus")
                    }.labelStyle(SpacedTrailingIconLabelStyle())
                        .frame(maxWidth: 100)
                        .expandHeight(alignment: .top)
                    Artboard(artboard: ArtboardModel(
                        layers: [example1layer1]
                    ))
                    .allowsHitTesting(false)
                    .scaleEffect(CGSize(0.25))
                    .frame(width: 512 / 4, height: 512 / 4)
                    .fixedSize()
                }
                
                Text("If the circle was a positive shape instead of a negative shape, it would have looked like this:")
                    .expandWidth(alignment: .leading)
                    .padding([.top, .bottom], 6)
                
                HStack {
                    VStack {
                        Label("1. Square", systemImage: "plus")
                        Label("2. Circle", systemImage: "plus")
                        Label("3. Square", systemImage: "plus")
                    }.labelStyle(SpacedTrailingIconLabelStyle())
                        .frame(maxWidth: 100)
                        .expandHeight(alignment: .top)
                    Artboard(artboard: ArtboardModel(
                        layers: [example1layer2]
                    ))
                    .allowsHitTesting(false)
                    .scaleEffect(CGSize(0.25))
                    .frame(width: 512 / 4, height: 512 / 4)
                    .fixedSize()
                }
            }.expand()
                .padding()
                .foregroundColor(.primary)
        }
    }
    
    static var title: some View {
        Label("Shapes", systemImage: "plus.forwardslash.minus")
            .font(.title)
    }
    
    static var description: some View {
        Group {
            Text("A positive shape")
            + Text(" adds ").bold()
            + Text("to your drawing. ")
            + Text("A negative shape")
            + Text(" subtracts ").bold()
            + Text("from your drawing.")
            
            (Text("Negative shapes affect")
            + Text(" all pixels on the current layer.")
                .bold())
                .padding(.top, 12)
            
            Text("This is distinct from using the eraser tool because this method can erase partial shapes. Negative shapes can also be selected and moved, just like positive shapes.")
                .padding(.top, 12)
        }
    }
}

#Preview {
    BooleanShapePage()
}
