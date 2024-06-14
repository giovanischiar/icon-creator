//
//  AndroidLegacyIconsCreator.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

/// Creates legacy Android icon files (potentially for API levels below a certain threshold).
struct AndroidLegacyIconsCreator {
	private let background: IconBackground
	private let foreground: IconForeground
    
    /// Initializes the creator with the background and foreground elements for the icon.
    /// - Parameters:
    ///   - background: The background of the icon.
    ///   - foreground: The foreground of the icon.
    init(background: IconBackground, foreground: IconForeground) {
        self.background = background
        self.foreground = foreground
    }
	
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

    /// Creates squircle and round legacy icon SVG files, deletes existing PNG and WebP files, and then generates PNG versions from the SVGs.
	func createAllIconFiles() {
		squircleAppIconFileCreator.create()
		roundAppIconFileCreator.create()
		svg2PNGConfigFileCreator.create()

		shell("find \(MainTraits.shared.resDirectory) -name \"ic_launcher.png\" -type f -delete")
		shell("find \(MainTraits.shared.resDirectory) -name \"ic_launcher.webp\" -type f -delete")

		shell("\(MainTraits.shared.svg2PNG) -f \(squircleAppIconFileCreator.filePath) -c \(svg2PNGConfigFileCreator.filePath)")
		shell("\(MainTraits.shared.svg2PNG) -f \(roundAppIconFileCreator.filePath) -c \(svg2PNGConfigFileCreator.filePath)")
	}
}
