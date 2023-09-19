//
//  JsonHelper.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import Foundation

func load<T: Decodable>(_ filename: String) -> T? {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        print("Couldn't find \(filename) in main bundle.")
        return nil
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        print("Couldn't load \(filename) from main bundle:\n\(error)")
        return nil
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        print("Couldn't parse \(filename) as \(T.self):\n\(error)")
        return nil
    }
}
