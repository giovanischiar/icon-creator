//
//  AndroidIconsCreator.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

/// Creates both adaptive and legacy Android app icons.
struct AndroidIconsCreator {
    private let iconBackground: IconBackground
    private let iconForeground: IconForeground
    
    /// Initializes the creator with the background and foreground elements for the icon.
    /// - Parameters:
    ///   - background: The background of the icon.
    ///   - foreground: The foreground of the icon.
    init(iconBackground: IconBackground, iconForeground: IconForeground) {
        self.iconBackground = iconBackground
        self.iconForeground = iconForeground
    }

    private var iconFilesCreator: AndroidIconFilesCreator {
        AndroidIconFilesCreator(
            background: iconBackground.background,
            iconForeground: iconForeground
        )
    }

    private var legacyIconsCreator: AndroidLegacyIconsCreator {
        AndroidLegacyIconsCreator(
            background: iconBackground,
            foreground: iconForeground
        )
    }

    /// Creates both the adaptive and legacy Android icons (potentially for API levels below a certain threshold).
    func createAllIcons() {
        iconFilesCreator.create()
        legacyIconsCreator.createAllIconFiles()
    }

    /// Creates both the adaptive and legacy Android icons (potentially for API levels below a threshold) with the foreground scaled automatically.
    func createAllIconsScaled() {
        iconFilesCreator.createScaled()
        legacyIconsCreator.createAllIconFiles()
    }
}
