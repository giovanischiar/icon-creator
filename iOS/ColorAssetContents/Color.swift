//
//  Color.swift
//
//
//  Created by Giovani Schiar on 14/12/22.
//

/// Represents a color stored in an Xcode asset catalog's Contents.json file.
struct Color: Codable {
    /// The color space the color components are defined in. This could be "srgb" (sRGB), "display-p3" (P3 DCI-P3), etc.
    let colorSpace: String
    
    /// The components of the color in the specified color space. The format of this data depends on the `colorSpace` value.
    ///  - For common color spaces like sRGB, components might be represented as a dictionary with keys like "red", "green", "blue", and "alpha".
    ///  - Other color spaces might use different component names or formats.
    let components: Component

    enum CodingKeys: String, CodingKey {
        case colorSpace = "color-space"
        case components
    }
}
