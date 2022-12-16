//
//  ColorAsset.swift
//
//
//  Created by Giovani Schiar on 14/12/22.
//

struct ColorAsset: Codable {
    let colors: [ColorKey]
}

extension ColorAsset {
    func dict(colorName: String) -> [String: String] {
        return [colorName: colors[0].color.components.hex]
    }
}
