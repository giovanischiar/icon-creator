//
//  TagBuilder.swift
//
//
//  Created by Giovani Schiar on 05/12/22.
//

@resultBuilder
struct TagBuilder {
    static func buildBlock(_ tag: any Tag) -> [any Tag] {
        return [tag]
    }
    
    static func buildBlock(_ tag: any Tag, _ tags: [any Tag]) -> [any Tag] {
        return [[tag], tags].flatMap { $0 }
    }

    static func buildBlock(_ tags: any Tag...) -> [any Tag] {
        return tags
    }
    
    static func buildBlock(_ tags: [(any Tag)]...) -> [any Tag] {
        return tags.flatMap { $0 }
    }

    static func buildOptional(_ tag: (any Tag)?) -> [any Tag] {
        return [] as [any Tag]
    }
}
