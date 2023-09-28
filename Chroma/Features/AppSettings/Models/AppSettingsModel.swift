//
//  AppSettingsModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

// copied from: https://stackoverflow.com/questions/73639471/how-to-get-list-of-all-recent-files-from-macos
class Spotlight {
    static func getUrlsFrom(query: MdQuerySet) -> [URL] {
        let queryString = query.rawValue
        var result: [URL] = []
        let query = MDQueryCreate(kCFAllocatorDefault, queryString as CFString, nil, nil)
        MDQueryExecute(query, CFOptionFlags(kMDQuerySynchronous.rawValue))
        for i in 0..<MDQueryGetResultCount(query) {
            if let rawPtr = MDQueryGetResultAtIndex(query, i) {
                let item = Unmanaged<MDItem>.fromOpaque(rawPtr).takeUnretainedValue()
                if let path = MDItemCopyAttribute(item, kMDItemPath) as? String {
                    if let url = URL(string: path) {
                        result.append(url)
                    }
                }
            }
        }
        return result
    }
}
enum MdQuerySet: String {
    // swiftlint:disable:next line_length
    case modifAndOpened30days = "(InRange(kMDItemFSContentChangeDate,$time.today(-30d),$time.today(+1d)) && InRange(kMDItemLastUsedDate,$time.today(-30d),$time.today(+1d)))"
}
func getRecentDocuments() -> [URL]? {
    return Spotlight.getUrlsFrom(query: MdQuerySet.modifAndOpened30days)
}

enum AppColorScheme: Codable {
    case followSystem
    case custom(ColorScheme)

    static func == (lhs: AppColorScheme, rhs: AppColorScheme) -> Bool {
        switch (lhs, rhs) {
        case (let .custom(lhs), let .custom(rhs)): return lhs == rhs
        case (.followSystem, .followSystem): return true
        default: return false
        }
    }
}

class AppSettingsModel: ObservableObject {
    @Published var colorScheme: AppColorScheme = .followSystem {
        didSet { saveProperty(key: "colorScheme", value: colorScheme) }
    }
    @Published var recentFiles: [URL] = [] {
        didSet { saveProperty(key: "recentFiles", value: recentFiles) }
    }
    @Published var palettes: [PaletteModel] = [.grays] {
        didSet { saveProperty(key: "palettes", value: palettes) }
    }
    @Published var showingSettings: Bool = false
    @Published var showingImport: Bool = false
    @Published var showingExport: Bool = false
    @Published var showingPngQuickExport: Bool = false
    @Published var showingDocumentation: Bool = false
    
    static let maximumRecentFiles = 20
    
    init(
        colorScheme: AppColorScheme? = nil,
        recentFiles: [URL]? = nil,
        palettes: [PaletteModel]? = nil
    ) {
        self.colorScheme = colorScheme 
            ?? getSavedProperty(key: "colorScheme", defaultValue: AppColorScheme.followSystem)
        self.recentFiles = recentFiles
            ?? getRecentDocuments()
            ?? getSavedProperty(key: "recentFiles", defaultValue: [])
//        self.palettes = palettes
//            ?? getSavedProperty(key: "palettes", defaultValue: [.grays])
    }
    
    func addRecentFile(_ url: URL) {
        if !recentFiles.contains(url) {
            recentFiles.append(url)
            if recentFiles.count > AppSettingsModel.maximumRecentFiles {
                _ = recentFiles.popLast()
            }
        }
    }

    var colorSchemeValue: ColorScheme? {
        switch colorScheme {
        case .custom(let value): return value
        case .followSystem: return nil
        }
    }

    var isDark: Bool {
        return colorScheme == .custom(.dark)
    }

    var isLight: Bool {
        return colorScheme == .custom(.light)
    }
}

private struct AppSettingsModelKey: EnvironmentKey {
    static var defaultValue = AppSettingsModel()
}

extension EnvironmentValues {
    var appSettings: AppSettingsModel {
        get { self[AppSettingsModelKey.self] }
        set { self[AppSettingsModelKey.self] = newValue }
    }
}
