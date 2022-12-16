//
//  iOSAppIconSetContentsJSONFetcher.swift
//
//
//  Created by Giovani Schiar on 14/12/22.
//

struct iOSAppIconSetContentsJSONFetcher {
    func fetch() -> iOSAppIconSetContentsJSON {
        let url = URL(fileURLWithPath: "\(MainTraits.shared.iosIconsFolder)/Contents.json")
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try! decoder.decode(iOSAppIconSetContentsJSON.self, from: data)
    }
}
