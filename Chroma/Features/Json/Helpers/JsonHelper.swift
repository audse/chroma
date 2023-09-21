//
//  JsonHelper.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import Foundation

func load<T: Decodable>(_ filename: String) -> T? {
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        print("Couldn't find \(filename) in main bundle.")
        return nil
    }

    return load(file)
}

func load<T: Decodable>(_ url: URL) -> T? {
    let data: Data

    do {
        data = try Data(contentsOf: url)
    } catch {
        print("Couldn't load \(url.absoluteString) from main bundle:\n\(error)")
        return nil
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        print("Couldn't parse \(url.absoluteString) as \(T.self):\n\(error)")
        return nil
    }
}
