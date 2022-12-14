//
//  AndroidSize.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

enum AndroidSize {
    case hdpi
    case mdpi
    case xhdpi
    case xxhdpi
    case xxxhdpi
}

extension AndroidSize {
    var size: Double {
        switch(self) {
            case .hdpi      : return 72.0
            case .mdpi      : return 48.0
            case .xhdpi     : return 96.0
            case .xxhdpi    : return 144.0
            case .xxxhdpi   : return 192.0
        }
    }
}
