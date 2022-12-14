//
//  BodylessTag.swift
//
//
//  Created by Giovani Schiar on 08/12/22.
//

protocol BodylessTag: Tag {}

extension BodylessTag {
    var body: [any Tag] {[] as [any Tag]}
}
