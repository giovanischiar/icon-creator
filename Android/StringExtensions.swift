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
