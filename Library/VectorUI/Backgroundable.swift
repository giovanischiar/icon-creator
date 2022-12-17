//
//  Backgroundable.swift
//
//
//  Created by Giovani Schiar on 17/12/22.
//

protocol Backgroundable: Tag {
    var background: Background { get }
}

extension Backgroundable {
    var body: [any Tag] {
        background.body
    }
}
