//
//  ExportPage.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI

struct ExportPage: View {
    @EnvironmentObject var file: FileModel

    @State var exportType: ExportType = .png
    @State var exportScale: Double = 1
    @State var isPngExporterPresented: Bool = false
    @State var isSvgExporterPresented: Bool = false

    @Binding var showing: Bool

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                Text("Export").font(.title)
                ExportTypeControl(exportType: $exportType)
                if exportType == .png {
                    ExportScaleControl(exportScale: $exportScale)
                }
                PngExporter(
                    isPresented: $isPngExporterPresented,
                    exportScale: $exportScale,
                    onCompletion: { isSuccess in showing = !isSuccess }
                )
                SvgExporter(
                    isPresented: $isSvgExporterPresented,
                    onCompletion: { isSuccess in showing = !isSuccess }
                )
                HStack {
                    Button("Cancel") { showing = false }
                        .tinted(.primaryBackgroundDark)
                    Button("Export") {
                        switch exportType {
                        case .png: isPngExporterPresented = true
                        case .svg: isSvgExporterPresented = true
                        }
                    }
                    .keyboardShortcut(.return, modifiers: [])
                    .tinted(.accentColor)
                }.composableButtonStyle(
                    Btn.defaultPadding
                    |> Btn.filledAccent
                    |> Btn.rounded
                    |> Btn.scaled
                )
            }
            .padding(24)
            .expandWidth(alignment: .leading)
            .frame(minWidth: 600, minHeight: 400)
        }
    }
}

#Preview {
    let artboard = PreviewArtboardModelBuilder().build()
    return ExportPage(showing: .constant(true))
        .environmentObject(FileModel(artboard: artboard))
}
