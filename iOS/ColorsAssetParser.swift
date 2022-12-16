//
//  ColorsAssetParser.swift
//
//
//  Created by Giovani Schiar on 14/12/22.
//

struct ColorsAssetParser {
    var colorSetFiles: [String] {
        let enumerator = FileManager.default.enumerator(atPath: MainTraits.shared.iosIconPaletteFolder)
        let filePaths = enumerator?.allObjects as! [String]
        return filePaths.filter{$0.contains(".colorset") && $0.contains("/Contents.json")}
    }

    func parseJSONValues() -> Theme {
        let dict = colorSetFiles.map {
            let url = URL(fileURLWithPath: "\(MainTraits.shared.iosIconPaletteFolder)/\($0)")
            let data = try! Data(contentsOf: url)
            let colorAsset = try! JSONDecoder().decode(ColorAsset.self, from: data)
            return colorAsset.dict(colorName: $0.colorNameInside) as [String: String]
        }.reduce([:], +)

        print(dict)

        return Theme(dict)
    }
}
