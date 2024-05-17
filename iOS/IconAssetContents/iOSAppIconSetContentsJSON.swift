//
//  iOSAppIconSetContentsJSON.swift
//
//
//  Created by Giovani Schiar on 14/12/22.
//

import Foundation

/// Represents the information about an iOS app icon set from its Contents.json file.
struct iOSAppIconSetContentsJSON: Codable {
    //// The array of images defined in the Contents.json file.
    var images: [Image]
    
    /// General information about the Contents.json file.
    let info: Info
}

extension iOSAppIconSetContentsJSON {
    /// Generates a configuration file for creating all the necessary image sizes specified in the Contents.json file.
    /// - Parameter directory: The directory where the generated configuration file will be placed.
    /// - Expected input format for SVG files: (mention any specific requirements here).
    func convertToSVG2PNGJSON(directory: String) -> SVG2PNGJSON {
        return SVG2PNGJSON(files: self.images.map {
            let size = $0.size.split(separator: "x")
            let scaleText = $0.scale ?? ""
            var scale = 1.0
            if (scaleText != "") {
                let index = scaleText.index(scaleText.startIndex, offsetBy: 0)
                let character = scaleText[index]
                scale = Double(character.wholeNumberValue ?? 1)
            }
            let widthString = size[0]
            let heightString = size[1]
            let width = (Double(widthString) ?? 0) * scale
            let height = (Double(heightString) ?? 0) * scale
            let nameSuffix =  "-\($0.size)\(scaleText != "" ? "@\(scaleText)" : scaleText)"
            return File(directory: directory, nameSuffix: nameSuffix, height: height, width: width)
        })
    }

    /// Renames all image filenames to follow the pattern used in iOS app icons.
     /// - Parameter fileName: The base filename to use for the renamed images.
     /// - Parameter fileSuffixes: An array of suffixes to append to the base filename for each image.
    func imagesNamesRenamed(fileName: String, fileSuffixes: [String]) -> iOSAppIconSetContentsJSON {
        var copy = self
        let imagesWithNames = self.images.enumerated().map { (index, element) in
            var newElement = element
            newElement.filename = "\(fileName)\(fileSuffixes[index]).png"
            return newElement
        }

        copy.images = imagesWithNames
        return copy
    }
}

extension iOSAppIconSetContentsJSON {
    /// Converts the struct to a JSON string representation.
    var description: String {
        do {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            let svg2PNGJSONData = try jsonEncoder.encode(self)
            return String(data: svg2PNGJSONData, encoding: .utf8) ?? "{}"
        } catch let err {
            print("\(err)")
            return "{}"
        }
    }
}
