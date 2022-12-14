//
//  SVG2PNGJSON.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

struct SVG2PNGJSON: Codable, CustomStringConvertible {
    let files: [File]
}

extension SVG2PNGJSON {
    var description: String {
        do {
            let svg2PNGJSONData = try JSONEncoder().encode(self)
            return String(data: svg2PNGJSONData, encoding: .utf8) ?? ""
        } catch let err {
            return "\(err)"
        }
    }
}
