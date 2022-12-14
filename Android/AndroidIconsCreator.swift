//
//  AndroidIconsCreator.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

struct AndroidIconsCreator {
    let background: IconBackground
    let foreground: IconForeground

    private var iconFilesCreator: AndroidIconFilesCreator {
        AndroidIconFilesCreator(
            background: background,
            foreground: foreground
        )
    }

    private var legacyIconsCreator: AndroidLegacyIconsCreator {
        AndroidLegacyIconsCreator(
            background: background,
            foreground: foreground
        )
    }

    func createAllIcons() {
        iconFilesCreator.create()
        legacyIconsCreator.createAllIconFiles()
    }
}
