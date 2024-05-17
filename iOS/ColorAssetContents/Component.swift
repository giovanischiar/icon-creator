//
//  Component.swift
//
//
//  Created by Giovani Schiar on 14/12/22.
//

/// Represents the color components of a color stored in an Xcode asset catalog's Contents.json file.
struct Component: Codable {
    /// The alpha component value in hexadecimal notation.
    let alpha: String
    
    /// The blue component value in hexadecimal notation.
    let blue: String
    
    //// The green component value in hexadecimal notation.
    let green: String
    
    /// The red component value in hexadecimal notation.
    let red: String
}

extension Component {
    
    /// The complete hex color string representation, including the leading hash symbol (#).
    var hex: String {
        "#\(red.dropFirst(2))\(green.dropFirst(2))\(blue.dropFirst(2))"
    }
}
