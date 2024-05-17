//
//  SVG2PNGJSON.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

import Foundation

/// Represents the JSON data structure used for SVG to PNG conversion configuration.
struct SVG2PNGJSON: Codable, CustomStringConvertible {
    /// An array of `File` objects specifying the details for each PNG image to be generated.
    let files: [File]
}

extension SVG2PNGJSON {
    /// Returns a pretty-printed JSON string representation of the `SVG2PNGJSON` object.
    var description: String {
        do {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            let svg2PNGJSONData = try jsonEncoder.encode(self)
            return String(data: svg2PNGJSONData, encoding: .utf8) ?? "{}"
        } catch let err {
            print("\(err)")
            return "{}"
        }
    }
}

extension SVG2PNGJSON {
    /// Returns an array containing the name suffixes for each PNG file specified in the configuration.
    var nameSuffixes: [String] {
        return self.files.map { $0.nameSuffix }
    }
}
