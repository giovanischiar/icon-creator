//
//  AppIcon.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

/// The generic app icon used in both iOS and Android.
struct AppIcon: Tag {
    private let background: Background
    private let foreground: Foreground
    private var padding = 0.0
    private let dimensions = Traits.shared.dimensions
    private var size: Double { dimensions.iconSize }
    
    /// Initializes the struct with a background, foreground, and optional padding.
    /// - Parameters:
    ///   - background: The background of the icon.
    ///   - foreground: The foreground of the icon.
    ///   - padding: The padding to be applied to all sides of the icon (defaults to 0).
    init(background: Background, foreground: Foreground, padding: Double = 0.0) {
        self.background = background
        self.foreground = foreground
        self.padding = padding
    }
    
    /// The body of the icon as a `Vector` with background and foreground elements positioned and sized based on padding.
    var body: [any Tag] {
        Vector(viewBox: [-padding, -padding, size + (padding * 2), size + (padding * 2)]) {
            background.contentBody
            foreground.center().contentBody
        }
    }
}

extension AppIcon {
    /// The SVG representation of the icon, generated using TagDecoder.
    var svg: String {
        return TagDecoder().prettyDecode(self, xmlType: .svg)
    }
}
