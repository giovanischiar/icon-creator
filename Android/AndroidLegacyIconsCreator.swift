//
//  AndroidLegacyIconsCreator.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

struct AndroidLegacyIconsCreator {
	let background: IconBackground
	let foreground: IconForeground 
	
	private var squircleAppIconFileCreator: FileCreator {
		FileCreator(
			content: AppIcon(
					background: background.squircle(), 
					foreground: foreground.foreground, 
					padding: 10.0
				).svg, 
			directory: MainTraits.shared.outputFolder,
			name: "\(MainTraits.shared.androidIconName)",
			ext: "svg"
		)
	}

	private var roundAppIconFileCreator: FileCreator {
		FileCreator(
			content: 
				AppIcon(
					background: background.circle(), 
					foreground: foreground.foreground, 
					padding: 10.0
				).svg, 
			directory: MainTraits.shared.outputFolder,
			name: "\(MainTraits.shared.androidIconRoundName)",
			ext: "svg"
		)
	}

	private var svg2PNGConfigFileCreator: FileCreator {
		FileCreator(
			content: "\(SVG2PNGConfigGenerator().androidSVG2JSONConfig)", 
			directory: MainTraits.shared.outputFolder,
			name: "\(MainTraits.shared.androidIconFormatName)",
			ext: "json"
		)
	}

	func createAllIconFiles() {
		squircleAppIconFileCreator.create()
		roundAppIconFileCreator.create()
		svg2PNGConfigFileCreator.create()

		shell("find \(MainTraits.shared.resDirectory) -name \"*.png\" -type f -delete")
		shell("find \(MainTraits.shared.resDirectory) -name \"*.webp\" -type f -delete")

		shell("\(MainTraits.shared.svg2PNG) -f \(squircleAppIconFileCreator.filePath) -c \(svg2PNGConfigFileCreator.filePath)")
		shell("\(MainTraits.shared.svg2PNG) -f \(roundAppIconFileCreator.filePath) -c \(svg2PNGConfigFileCreator.filePath)")
	}
}
