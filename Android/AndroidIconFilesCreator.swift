//
//  AndroidIconFilesCreator.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

struct AndroidIconFilesCreator {
	let background: Background
	let iconForeground: IconForeground

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

	func create() {
		backgroundFileCreator.create()
		foregroundFileCreator.create()
	}

	func createScaled() {
		backgroundFileCreator.create()
		foregroundFileCreatorScaled.create()
	}
}
