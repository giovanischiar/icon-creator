//
//  MainTraits.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

struct MainTraits {
    let appDirectory             = "../\(CommandLine.arguments[2])"
    var platform                 : Platform { CommandLine.arguments[1].platform }

    var resDirectory             : String { "\(appDirectory)/app/src/main/res" }
    let outputFolder             = "output"
    let androidIconPaletteName   = "iconpalette"
    let androidIconFormatName    = "android-icon-format"
    let androidIconName          = "ic_launcher"
    
    var outputFolderName         : String { "\(outputFolder)" }
    var androidIconFormatFile    : String { "\(outputFolderName)/\(androidIconFormatName).json" }
    var androidIconRoundName     : String { "\(androidIconName)_round" }
    var androidIconsFolder       : String { "\(resDirectory)/mipmap"}
    var drawableDirectory        : String { "\(resDirectory)/drawable" }
    var iconPaletteFile          : String { "\(resDirectory)/values/\(androidIconPaletteName).xml" }

    var svg2PNG                  = "Library/svg2png"

    let iosIconPaletteName       = "AppIconPalette.xcassets"
    let iosIconAssetsName        = "Assets.xcassets"
    let iosIconFormatName        = "ios-icon-format"
    
    lazy var iosIconName: String = {
        let enumerator = FileManager.default.enumerator(atPath: iosAssetsFolder)
        let filePaths = enumerator?.allObjects as! [String]
        let txtFilePaths = filePaths.filter{$0.contains(".appiconset") && !$0.contains("/")}
        return !txtFilePaths.isEmpty ? String(txtFilePaths[0].split(separator: ".")[0]) : "AppIcon"
    }()

    var iosIconPaletteFolder     : String { "\(appDirectory)/\(iosIconPaletteName)" }
    var iosAssetsFolder          : String { "\(appDirectory)/\(iosIconAssetsName)" }
    var iosIconsFolder           : String { mutating get { "\(iosAssetsFolder)/\(iosIconName).appiconset" } }

    private init() {}
    static var shared = MainTraits()
}
