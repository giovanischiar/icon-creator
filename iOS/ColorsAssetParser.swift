//
//  ColorsAssetParser.swift
//
//
//  Created by Giovani Schiar on 14/12/22.
//

import Foundation

/// Parses color asset Contents.json files and extracts color values.
struct ColorsAssetParser {
    /// An array of paths to all Contents.json files found within color asset folders.
    var colorSetFiles: [String] {
        let enumerator = FileManager.default.enumerator(atPath: MainTraits.shared.iosIconPaletteFolder)
        let filePaths = enumerator?.allObjects as! [String]
        return filePaths.filter{$0.contains(".colorset") && $0.contains("/Contents.json")}
    }

    /// Parses all Contents.json files found in color asset folders.
    /// - Returns: The single dictionary containing all extracted color values.
    func parseJSONValues() -> [String: String] {
        let dict = colorSetFiles.map {
            let url = URL(fileURLWithPath: "\(MainTraits.shared.iosIconPaletteFolder)/\($0)")
            let data = try! Data(contentsOf: url)
            let colorAsset = try! JSONDecoder().decode(ColorAsset.self, from: data)
            return colorAsset.dict(colorName: $0.colorNameInside) as [String: String]
        }.reduce([:], +)
        return dict
    }
}
