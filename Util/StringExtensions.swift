//
//  StringExtensions.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

extension String {
    var androidSize: AndroidSize {
        switch(self) {
            case "hdpi"     : return .hdpi
            case "mdpi"     : return .mdpi
            case "xhdpi"    : return .xhdpi
            case "xxhdpi"   : return .xxhdpi
            case "xxxhdpi"  : return .xxxhdpi
            default         : return .hdpi
        }
    }
    
    var androidSizeInside: AndroidSize {
        (String(self.split(separator: "-")[1])).androidSize
    }
}

extension String {
    var platform: Platform { self == "ios" ? .iOS : .android }
}

extension String {
    var colorNameInside: String {
        return String(self.split(separator: ".")[0])
    }
}

extension [String:String] {
    static func +(lhs: [String:String], rhs: [String: String]) -> [String: String] {
        return lhs.merging(rhs) { (current, _) in current }
    }
}

extension String {
    static prefix func -(str: String) -> String {
        let colorValue = Traits.shared.theme[str] ?? ""
        if (colorValue == "") { print("⚠️ Key \(str) doesn't exist") }
        return colorValue
    }
}
