//
//  MainTraits.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

import Foundation

/// All necessary traits for the application found in the icon folder and assets folder of both Android and iOS projects.
struct MainTraits {
    /// The iOS project directory containing icon and color assets.
    let appDirectory             = "../\(CommandLine.arguments[2])"
    
    /// The platform specified (iOS or Android).
    var platform                 : Platform { CommandLine.arguments[1].platform }

    /// The resource directory of the Android project.
    var resDirectory             : String { "\(appDirectory)/app/src/main/res" }
    
    /// The name of the folder where generated icons will be placed.
    let outputFolder             = "output"
    
    /// The name of the file on the Android Studio that contains the colors of the icon.
    let androidIconPaletteName   = "iconpalette"
    /// The name of the file on the format used to generate all the necessary images of the icon.
    let androidIconFormatName    = "android-icon-format"
    /// The name of the icon on Android Studio project res folder..
    let androidIconName          = "ic_launcher"
    
    
    /// The output name of the folder.
    var outputFolderName         : String { "\(outputFolder)" }
    
    /// The android format file directory used as a input to generate the images.
    var androidIconFormatFile    : String { "\(outputFolderName)/\(androidIconFormatName).json" }
    
    /// The name of the round version of the legacy icon.
    var androidIconRoundName     : String { "\(androidIconName)_round" }
    
    /// The name of the directory where the Android icons are locared.
    var androidIconsFolder       : String { "\(resDirectory)/mipmap"}
    
    /// The name of the drawable directory.
    var drawableDirectory        : String { "\(resDirectory)/drawable" }
    
    /// The icon Android colors palette whole path to the file.
    var iconPaletteFile          : String { "\(resDirectory)/values/\(androidIconPaletteName).xml" }

    /// The svg2PNG path, used to generate the images from the SVG generated.
    var svg2PNG                  = "Library/svg2png"

    /// The iOS colors palette name.
    let iosIconPaletteName       = "AppIconPalette.xcassets"
    
    /// The iOS Icon assets name.
    let iosIconAssetsName        = "Assets.xcassets"
    
    /// The iOS format file directory used as a input to generate the images.
    let iosIconFormatName        = "ios-icon-format"
    
    /// The iOS icon set name, handling the case where no app icon set is found.
    lazy var iosIconName: String = {
        let enumerator = FileManager.default.enumerator(atPath: iosAssetsFolder)
        let filePaths = enumerator?.allObjects as! [String]
        let txtFilePaths = filePaths.filter{$0.contains(".appiconset") && !$0.contains("/")}
        return !txtFilePaths.isEmpty ? String(txtFilePaths[0].split(separator: ".")[0]) : "AppIcon"
    }()

    /// The name of the icon colors palette folder name.
    var iosIconPaletteFolder     : String { "\(appDirectory)/\(iosIconPaletteName)" }
    
    /// The name of the icon assets folder name.
    var iosAssetsFolder          : String { "\(appDirectory)/\(iosIconAssetsName)" }
    
    /// The name of the iOS icons folder.
    var iosIconsFolder           : String { mutating get { "\(iosAssetsFolder)/\(iosIconName).appiconset" } }

    private init() {}
    
    /// The singleton instance of this struct.
    static var shared = MainTraits()
}
