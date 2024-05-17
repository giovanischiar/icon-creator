//
//  ColorKey.swift
//
//
//  Created by Giovani Schiar on 14/12/22.
//

/// Represents a color along with its variations for different appearances (e.g., light/dark mode) or themes stored in an Xcode asset catalog's Contents.json file.
struct ColorKey: Codable {
    /// An array of appearances this color applies to (e.g., light mode, dark mode, etc.).
    let appearances: [Appearance]?
    
    /// The core color information.
    let color: Color
    
    /// The platform this color applies to, such as "universal" for all platforms.
    let idiom: String
}
