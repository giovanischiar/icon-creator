//
//  iOSIconsCreator.swift
//
//
//  Created by Giovani Schiar on 14/12/22.
//

/// Creates app icons for iOS.
struct iOSIconsCreator {
    private let background: Background
    private let foreground: Foreground
    
    /// Initializes the creator with the background and foreground elements for the icon.
    /// - Parameters:
    ///   - background: The background of the icon.
    ///   - foreground: The foreground of the icon.
    init(iconBackground: IconBackground, iconForeground: IconForeground) {
        self.background = iconBackground.background
        self.foreground = iconForeground.foreground
    }

    private lazy var appIconSetContentsJSON: iOSAppIconSetContentsJSON = {
        return iOSAppIconSetContentsJSONFetcher().fetch()
    }()

    private lazy var svg2PNGJSON: SVG2PNGJSON = {
        return SVG2PNGConfigGenerator().iOSSVG2JSONConfig(
            iosAppIconSetContentsJSON: appIconSetContentsJSON
        )
    }()

    private lazy var svg2PNGFileCreator: FileCreator = {
        return FileCreator(
            content: "\(svg2PNGJSON)", 
            directory: MainTraits.shared.outputFolder,
            name: "\(MainTraits.shared.iosIconFormatName)",
            ext: "json"
        )
    }()

    private var appIconFileCreator: FileCreator {
        FileCreator(
            content: AppIcon(
                background: background, 
                foreground: foreground
            ).svg, 
            directory: MainTraits.shared.outputFolder,
            name: MainTraits.shared.iosIconName,
            ext: "svg"
        )
    }

    private var renamedAppIconSetContentsJSONFileCreator: FileCreator {
        mutating get {
            let renamedAppIconSetContentsJSON = appIconSetContentsJSON.imagesNamesRenamed(
                fileName: MainTraits.shared.iosIconName, 
                fileSuffixes: svg2PNGJSON.nameSuffixes
            )

            return FileCreator(
                content: "\(renamedAppIconSetContentsJSON.description)", 
                directory: MainTraits.shared.iosIconsFolder,
                name: "Contents",
                ext: "json"
            )
        }
    }

    /// Creates all the app icons with their different scales.
    mutating func createAllIcons() {
        shell("find \(MainTraits.shared.outputFolder) -name \"*.svg\" -type f -delete")
        appIconFileCreator.create()
        svg2PNGFileCreator.create()
        shell("find \(MainTraits.shared.iosIconsFolder) -name \"*.png\" -type f -delete")
        shell("\(MainTraits.shared.svg2PNG) -f \(appIconFileCreator.filePath) -c \(svg2PNGFileCreator.filePath)")
        renamedAppIconSetContentsJSONFileCreator.create()
    }
}
