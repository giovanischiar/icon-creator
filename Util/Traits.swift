//
//  Traits.swift
//
//
//  Created by Giovani Schiar on 08/12/22.
//

/// Stores global configuration data for the application.
struct Traits {
    /// The dimensions used for various UI elements.
    var dimensions = Dimensions()
    
    /// The color theme dictionary containing key-value pairs for color names and their corresponding values.
    var theme: [String: String] = [:]
    
    /// A singleton instance of Traits accessible throughout the application.
    static var shared = Traits()
}
