//
//  SVG2PNGConfigGenerator.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

import Foundation

/// Generates SVG to PNG conversion configuration files.
struct SVG2PNGConfigGenerator {
    
    /// Generates a configuration file (JSON format) for iOS SVG to PNG conversion.
    /// - Parameter iosAppIconSetContentsJSON: The JSON data representing the iOS app icon sets.
    /// - Returns: A `SVG2PNGJSON` object containing the configuration for iOS SVG to PNG conversion.
    func iOSSVG2JSONConfig(iosAppIconSetContentsJSON: iOSAppIconSetContentsJSON) -> SVG2PNGJSON {
        return iosAppIconSetContentsJSON.convertToSVG2PNGJSON(
            directory: MainTraits.shared.iosIconsFolder
        )
    }

    
    /// Generates a configuration file (JSON format) for Android SVG to PNG conversion.
    /// - Returns: A `SVG2PNGJSON` object containing the configuration for Android SVG to PNG conversion.
    var androidSVG2JSONConfig: SVG2PNGJSON {
        let mipMapFolders = findIconFolders(folderName: "mipmap")
        let files = mipMapFolders.map {
            let androidSize = $0.androidSizeInside
            let size = androidSize.size
            return File(
                directory: "\(MainTraits.shared.resDirectory)/\($0)",
                nameSuffix: "",
                height: size,
                width: size
            )
        }
        
        return SVG2PNGJSON(files: files)
    }

    private func findIconFolders(folderName: String) -> [String] {
        let enumerator = FileManager.default.enumerator(atPath: MainTraits.shared.resDirectory)
        let filePaths = enumerator?.allObjects as! [String]
        return filePaths.filter{$0.contains(folderName) && !$0.contains("/") && !$0.contains("-anydpi")}
    }
}
