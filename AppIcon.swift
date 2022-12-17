//
//  AppIcon.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

struct AppIcon: Tag {
    let background: Background
    let foreground: IconForeground
    var padding = 0.0
    let dimensions = Traits.shared.dimensions
    var size: Double { dimensions.iconSize }
    
    var body: [any Tag] {
        Vector(viewBox: [-padding, -padding, size + (padding * 2), size + (padding * 2)]) {
            background.contentBody
            foreground.center()
        }
    }
}

extension AppIcon {
    var svg: String {
        return TagDecoder().prettyDecode(self, xmlType: .svg)
    }
}