//
//  ColorAsset.swift
//
//
//  Created by Giovani Schiar on 14/12/22.
//

/// Represents a collection of named colors stored in an Xcode asset catalog's Contents.json file.
struct ColorAsset: Codable {
    /// An array of colors defined within the asset catalog.
    let colors: [ColorKey]
}

extension ColorAsset {
    
    /// Get the hex value of a color by its name within the asset catalog.
    /// - Parameter colorName: The name of the color to retrieve.
    /// - Returns: A dictionary containing a single key-value pair where the key is the color name and the value is the hex representation of the color components.
    func dict(colorName: String) -> [String: String] {
        return [colorName: colors[0].color.components.hex]
    }
}
