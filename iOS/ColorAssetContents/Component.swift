//
//  Component.swift
//
//
//  Created by Giovani Schiar on 14/12/22.
//

struct Component: Codable {
    let alpha: String
    let blue: String
    let green: String
    let red: String
}

extension Component {
    var hex: String {
        "#\(red.dropFirst(2))\(green.dropFirst(2))\(blue.dropFirst(2))"
    }
}
