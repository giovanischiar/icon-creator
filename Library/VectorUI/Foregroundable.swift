//
//  Foregroundable.swift
//
//
//  Created by Giovani Schiar on 17/12/22.
//

protocol Foregroundable: Tag {
    var foreground: Foreground { get }
}

extension Foregroundable {
    var body: [any Tag] {
        foreground.body
    }
}
