//
//  File.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

/// Represents a configuration file entry for SVG to PNG conversion.
struct File: Codable {
    /// The directory where the converted PNG images will be placed.
    let directory: String
    
    /// The suffix to be appended to the names of the converted PNG images.
    let nameSuffix: String
    
    /// The desired height of the converted PNG images in pixels (Double for flexibility).
    let height: Double
    
    /// The desired width of the converted PNG images in pixels (Double for flexibility).
    let width: Double
}
