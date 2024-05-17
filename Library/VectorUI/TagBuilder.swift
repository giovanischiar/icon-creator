//
//  TagBuilder.swift
//
//
//  Created by Giovani Schiar on 05/12/22.
//

/// A builder used to construct `Tag` elements in a Swift-like syntax for creating tag hierarchies.
@resultBuilder
struct TagBuilder {
    /// Creates an empty list of tags.
    /// - Returns: An empty array of `any Tag`.
    static func buildBlock() -> [any Tag] {
        return [] as [any Tag]
    }
    
    /// Creates a list containing a single tag.
    /// - Parameter tag: The `Tag` element to include.
    /// - Returns: An array containing the provided `tag`.
    static func buildBlock(_ tag: any Tag) -> [any Tag] {
        return [tag]
    }
    
    /// Creates a list of tags by combining a single tag with a list of tags.
    /// - Parameters:
    ///   - tag: The first `Tag` element.
    ///   - tags: A list of additional `Tag` elements.
    /// - Returns: A flattened array containing the provided `tag` followed by the elements from `tags`.
    static func buildBlock(_ tag: any Tag, _ tags: [any Tag]) -> [any Tag] {
        return [[tag], tags].flatMap { $0 }
    }
    
    /// Creates a list of tags from a variable number of tag arguments.
    /// - Parameter tags: A variadic sequence of `Tag` elements.
    /// - Returns: The provided `tags` sequence converted to an array.
    static func buildBlock(_ tags: any Tag...) -> [any Tag] {
        return tags
    }
    
    /// Creates a list of tags by flattening a variable number of tag lists.
    /// - Parameter tags: A variadic sequence of arrays containing `Tag` elements.
    /// - Returns: A flattened array containing all tags from the provided `tags` sequence.
    static func buildBlock(_ tags: [(any Tag)]...) -> [any Tag] {
        return tags.flatMap { $0 }
    }

    /// Handles an optional `Tag` element. If no value is present, an empty list is returned.
    /// - Parameter tag: An optional `Tag` element.
    /// - Returns: An empty array if `tag` is nil, otherwise an array containing the unwrapped `tag`.
    static func buildOptional(_ tag: (any Tag)?) -> [any Tag] {
        return [] as [any Tag]
    }
}
