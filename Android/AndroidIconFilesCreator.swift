//
//  AndroidIconFilesCreator.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

/// Creates the Android vector drawable files for the app icon.
struct AndroidIconFilesCreator {
	private let background: Background
    private let iconForeground: IconForeground

    /// Initializes the creator with the background and foreground elements for the icon.
    /// - Parameters:
    ///   - background: The background of the icon.
    ///   - iconForeground: The foreground of the icon.
    init(background: Background, iconForeground: IconForeground) {
        self.background = background
        self.iconForeground = iconForeground
    }
    
	private var backgroundFileCreator: FileCreator {
		FileCreator(
			content: background.vectordrawable, 
			directory: MainTraits.shared.drawableDirectory,
			name: "\(MainTraits.shared.androidIconName)_background",
			ext: "xml"
		)
	}

	private var foregroundFileCreator: FileCreator {
		FileCreator(
			content: iconForeground.center().vectordrawable, 
			directory: "\(MainTraits.shared.drawableDirectory)-v24",
			name: "\(MainTraits.shared.androidIconName)_foreground",
			ext: "xml"
		)
	}

	private var foregroundFileCreatorScaled: FileCreator {
		FileCreator(
			content: iconForeground.scaled(factor: 0.62).center().vectordrawable, 
			directory: "\(MainTraits.shared.drawableDirectory)-v24",
			name: "\(MainTraits.shared.androidIconName)_foreground",
			ext: "xml"
		)
	}

    /// Creates files for both the background and the unscaled foreground vector drawable of the Android icon.
	func create() {
		backgroundFileCreator.create()
		foregroundFileCreator.create()
	}

    /// Creates files for the background and a scaled foreground vector drawable of the Android icon (likely for higher API levels).
	func createScaled() {
		backgroundFileCreator.create()
		foregroundFileCreatorScaled.create()
	}
}
