//
//  Image.swift
//
//
//  Created by Giovani Schiar on 14/12/22.
//

/// Represents an image stored in an Xcode asset catalog's Contents.json file.
struct Image: Codable {
    /// The name of the image file, including the extension if present.
    var filename: String?
    
    /// The idiom that this image applies to (e.g., "ios", "mac").
    let idiom: String
    
    /// The scale factor applied to the original image size. The format is a number followed by 'x' (e.g., '2x' for double size).
    let scale: String?
    
    /// The platform this image applies to, such as "universal" for all platforms. **This property is optional and typically only specified for the "ios" idiom value.**
    let platform: String?
    
    /// The width and height of the image, formatted as "width x height".
    let size: String
}
