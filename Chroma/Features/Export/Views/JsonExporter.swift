//
//  JsonExporter.swift
//  Chroma
//
//  Created by Audrey Serene on 9/19/23.
//

import SwiftUI

struct JsonExporter: View {
    @EnvironmentObject var file: FileModel
    @Binding var isPresented: Bool

    var onCompletion: ((Bool) -> Void)?

    var body: some View {
        Spacer().fileExporter(
            isPresented: $isPresented,
            document: getJsonDocument(),
            contentType: .chroma,
            defaultFilename: "\(file.name).chroma",
            onCompletion: { result in
                if let onCompletion = onCompletion {
                    switch result {
                    case .success: onCompletion(true)
                    case .failure: onCompletion(false)
                    }
                }
            }
        )
    }

    func getJsonDocument() -> JsonDocument {
        do {
            let document = try JsonDocument(file)
            return document
        } catch {
            print("Error!! \(error)")
            return JsonDocument()
        }
    }
}

struct JsonExporter_Previews: PreviewProvider {
    static var artboard = PreviewArtboardModelBuilder().build()
    static var previews: some View {
        JsonExporter(isPresented: .constant(false))
            .environmentObject(FileModel(artboard: artboard))
    }
}
