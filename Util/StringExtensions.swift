//
//  StringExtensions.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

extension String {
    /// Converts the string representation of an Android density (e.g., "hdpi") to the corresponding `AndroidSize` enum case.
    ///
    /// - Returns: The `AndroidSize` enum case for the provided string, or `.hdpi` if the string doesn't match a known density.
    var androidSize: AndroidSize {
        switch(self) {
            case "hdpi"     : return .hdpi
            case "mdpi"     : return .mdpi
            case "xhdpi"    : return .xhdpi
            case "xxhdpi"   : return .xxhdpi
            case "xxxhdpi"  : return .xxxhdpi
            default         : return .hdpi
        }
    }
    
    /// Extracts the Android density (e.g., "hdpi") from a folder name in the format "mipmap-(android size)".
    ///
    /// - Returns: The `AndroidSize` enum case extracted from the folder name, or `.hdpi` if the format is invalid.
    var androidSizeInside: AndroidSize {
        (String(self.split(separator: "-")[1])).androidSize
    }
}

extension String {
    /// Converts the string to the corresponding `Platform` enum case (iOS or Android).
    ///
    /// - Returns: `.iOS` if the string is "ios", otherwise `.android`.
    var platform: Platform { self == "ios" ? .iOS : .android }
}

extension String {
    /// Extracts the color name from a string containing a color reference (e.g., "color.red").
    ///
    /// - Returns: The color name ("color" in the example) extracted from the string, before the first dot (.).
    var colorNameInside: String {
        return String(self.split(separator: ".")[0])
    }
}

extension [String:String] {
    /// Merges two string dictionaries, giving priority to values in the left-hand side dictionary.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side dictionary.
    ///   - rhs: The right-hand side dictionary.
    /// - Returns: A new dictionary containing the merged key-value pairs.
    static func +(lhs: [String:String], rhs: [String: String]) -> [String: String] {
        return lhs.merging(rhs) { (current, _) in current }
    }
}

extension String {
    /// Retrieves the color value for a given color name from the theme assets.
    ///
    /// - Parameter str: The color name to look up (e.g., "red").
    /// - Returns: The color value from the theme assets, or an empty string if the color is not found.
    /// - Prints a warning message if the color name is not found in the theme.
    static prefix func -(str: String) -> String {
        let colorValue = Traits.shared.theme[str] ?? ""
        if (colorValue == "") { print("⚠️ Key \(str) doesn't exist") }
        return colorValue
    }
}
