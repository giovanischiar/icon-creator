//
//  Color.swift
//
//
//  Created by Giovani Schiar on 14/12/22.
//

struct Color: Codable {
    let colorSpace: String
    let components: Component

    enum CodingKeys: String, CodingKey {
        case colorSpace = "color-space"
        case components
    }
}
