//
//  AndroidLegacyIconsCreator.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

struct AndroidLegacyIconsCreator {
	let background: IconBackground
	let foreground: IconForeground 

	private let svg2png = "Library/svg2png"
	
	private var squircleAppIconFileCreator: FileCreator {
		FileCreator(
			content: AppIcon(
					background: background, 
					foreground: foreground, 
					backgroundType: .squircle,
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
					background: background, 
					foreground: foreground, 
					backgroundType: .circle,
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
		if (!squircleAppIconFileCreator.create()) { print("squircleAppIconFileCreator failed") }
		if (!roundAppIconFileCreator.create()) { print("roundAppIconFileCreator failed") }
		if (!svg2PNGConfigFileCreator.create()) { print("svg2PNGConfigFileCreator failed") }

		shell("\(svg2png) -f \(squircleAppIconFileCreator.filePath) -c \(svg2PNGConfigFileCreator.filePath)")
		shell("\(svg2png) -f \(roundAppIconFileCreator.filePath) -c \(svg2PNGConfigFileCreator.filePath)")
	}
}
