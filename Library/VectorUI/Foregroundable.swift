//
//  Foregroundable.swift
//
//
//  Created by Giovani Schiar on 17/12/22.
//

/// A protocol used to define elements that can have a foreground defined using the `Foreground` struct.
protocol Foregroundable: Tag {
    /// The foreground of the element.
    var foreground: Foreground { get }
}

extension Foregroundable {
    /// The body of the classes that conform to the Foregroundable protocol is the body of its own foreground.
    var body: [any Tag] {
        foreground.body
    }
}
