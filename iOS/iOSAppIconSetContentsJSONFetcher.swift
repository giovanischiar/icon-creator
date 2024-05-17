//
//  iOSAppIconSetContentsJSONFetcher.swift
//
//
//  Created by Giovani Schiar on 14/12/22.
//

import Foundation

/// Decodes the Contents.json file from the iOS app icon set folder.
struct iOSAppIconSetContentsJSONFetcher {
    /// Fetches and decodes the Contents.json file from the iOS app icon set folder.
    /// - Returns: The struct representing the JSON decodified.
    func fetch() -> iOSAppIconSetContentsJSON {
        let url = URL(fileURLWithPath: "\(MainTraits.shared.iosIconsFolder)/Contents.json")
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try! decoder.decode(iOSAppIconSetContentsJSON.self, from: data)
    }
}
