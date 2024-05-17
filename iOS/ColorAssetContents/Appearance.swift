//
//  Appearance.swift
//
//
//  Created by Giovani Schiar on 14/12/22.
//

/// Represents an appearance setting from a Contents.json file within an Xcode asset catalog.
struct Appearance: Codable {
    /// The type of appearance setting. This can be either "luminosity" or "contrast".
    let appearance: String
    
    /// The value of the appearance setting.
    ///  * For "luminosity", this can be "dark" or "light".
    ///  * For "contrast", this can be "high".
    let value: String
}
