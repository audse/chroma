//
//  FilePreviewList.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

extension URL: Identifiable {
    public var id: String {
        return self.absoluteString
    }
}

private struct File: Identifiable {
    let url: URL
    let file: FileModel
    
    var id: String { return url.absoluteString }
}

struct FilePreviewList: View {
    @Environment(\.newDocument) var newDocument
    @Environment(\.openDocument) var openDocument
    @EnvironmentObject var appSettings: AppSettingsModel
    
    @State var selectedFile: FileModel?

    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var newButton: some View {
        Text("New")
            .expand()
            .background(Color.almostClear)
            .gesture(TapGesture(count: 2).onEnded {})
            .simultaneousGesture(TapGesture(count: 1).onEnded {
                newDocument(ChromaDocument(FileModel.Empty()))
            })
            .foregroundStyle(.primary)
            .buttonStyle(.plain)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(
                        .tertiary,
                        style: StrokeStyle(
                            lineWidth: 3,
                            lineCap: .round,
                            dash: [6]
                        )
                    ))
            .aspectRatio(1, contentMode: .fit)
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                newButton
                ForEach(getRecentFiles(), id: \.id) { file in
                    Button {
                        open(file.url)
                    } label: {
                        FilePreview(file: file.file)
                            .expand()
                            .composableButtonStyle(Btn.scaled)
                    }.buttonStyle(.plain)
                }
            }
        }.expand()
    }
    
    private func getRecentFiles() -> [File] {
        appSettings.recentFiles.filterMap { url in
            if let file: FileModel = loadJson(url) {
                return File(url: url, file: file)
            }
            return nil
        }
    }
    
    func open(_ url: URL) {
        Task {
            try await openDocument(at: url)
        }
    }
}

#Preview {
    FilePreviewList()
        .environmentObject(AppSettingsModel())
}
