//
//  BodylessTag.swift
//
//
//  Created by Giovani Schiar on 08/12/22.
//

/// A protocol used to mark tags that don't have a body (content) in the SVG representation.
/// These tags are used to encapsulate SVG/XML objects within the main structure.
protocol BodylessTag: Tag {}

extension BodylessTag {
    /// Bodyless tags don't have any content, so their body is an empty array.
    var body: [any Tag] {[] as [any Tag]}
}
