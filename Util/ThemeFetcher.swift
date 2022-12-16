//
//  ThemeFetcher.swift
//
//
//  Created by Giovani Schiar on 14/12/22.
//

struct ThemeFetcher {
    var platform: Platform = .android
    
    func fetch() async -> Theme {
        switch(platform) {
            case .android: return try! await ColorsResParser().parseXMLValues()
            case .iOS: return ColorsAssetParser().parseJSONValues()
        }
    }
}
