//
//  AndroidIconFilesCreator.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

struct AndroidIconFilesCreator {
	let background: Background
	let foreground: IconForeground

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
			content: IconForeground(disposition: 15.0, scaleFactor: 0.62).vectordrawable, 
			directory: "\(MainTraits.shared.drawableDirectory)-v24",
			name: "\(MainTraits.shared.androidIconName)_foreground",
			ext: "xml"
		)
	}

	func create() {
		backgroundFileCreator.create()
		foregroundFileCreator.create()
	}
}
