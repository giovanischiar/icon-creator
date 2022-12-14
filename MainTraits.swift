//
//  MainTraits.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

struct MainTraits {
    let resDirectory            = "../../app/src/main/res"
    let outputFolder            = "output"
    let androidIconPaletteName  = "iconpalette"
    let androidIconFormatName   = "android-icon-format"
    let androidIconName         = "ic_launcher"
    
    var outputFolderName        : String { "\(outputFolder)" }
    var androidIconFormatFile   : String { "\(outputFolderName)/\(androidIconFormatName).json" }
    var androidIconRoundName    : String { "\(androidIconName)_round" }
    var androidIconsFolder      : String { "\(resDirectory)/mipmap"}
    var drawableDirectory       : String { "\(resDirectory)/drawable" }
    var iconPaletteFile         : String { "\(resDirectory)/values/\(androidIconPaletteName).xml" }
    
    private init() {}
    static let shared = MainTraits()
}
