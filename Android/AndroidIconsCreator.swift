//
//  AndroidIconsCreator.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

struct AndroidIconsCreator {
    let iconBackground: IconBackground
    let iconForeground: IconForeground

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

    func createAllIcons() {
        iconFilesCreator.create()
        legacyIconsCreator.createAllIconFiles()
    }
}
