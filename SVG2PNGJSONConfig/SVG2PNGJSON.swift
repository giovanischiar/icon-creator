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
    var nameSuffixes: [String] {
        return self.files.map { $0.nameSuffix }
    }
}
