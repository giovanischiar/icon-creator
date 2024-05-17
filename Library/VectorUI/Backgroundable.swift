//
//  Backgroundable.swift
//
//
//  Created by Giovani Schiar on 17/12/22.
//

/// A protocol used to define elements that can have a background defined using the `Background` struct.
protocol Backgroundable: Tag {
    /// The background of the element.
    var background: Background { get }
}

extension Backgroundable {
    /// The body of the classes that conform to the Backgroundable protocol is the body of its own background.
    var body: [any Tag] {
        background.body
    }
}
