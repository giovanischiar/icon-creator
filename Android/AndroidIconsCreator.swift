//
//  AndroidIconsCreator.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

struct AndroidIconsCreator {
    let iconBackground: IconBackground
    let foreground: IconForeground

    private var iconFilesCreator: AndroidIconFilesCreator {
        AndroidIconFilesCreator(
            background: iconBackground.background,
            foreground: foreground
        )
    }

    private var legacyIconsCreator: AndroidLegacyIconsCreator {
        AndroidLegacyIconsCreator(
            background: iconBackground,
            foreground: foreground
        )
    }

    func createAllIcons() {
        iconFilesCreator.create()
        legacyIconsCreator.createAllIconFiles()
    }
}
