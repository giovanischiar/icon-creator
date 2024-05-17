//
//  ThemeFetcher.swift
//
//
//  Created by Giovani Schiar on 14/12/22.
//

/// Fetches theme data based on the chosen platform.
struct ThemeFetcher {
    /// The target platform for theme retrieval.
    var platform: Platform = .android
    
    
    /// Fetches the color theme data from platform-specific assets.
    /// - Returns: A dictionary containing all color names and their corresponding values.
    func fetch() async -> [String: String] {
        switch(platform) {
            case .android: return try! await ColorsResParser().parseXMLValues()
            case .iOS: return ColorsAssetParser().parseJSONValues()
        }
    }
}
