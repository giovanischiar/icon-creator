//
//  AndroidSize.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

/// Represents the different default Android icon sizes (densities).
enum AndroidSize {
    /// High density (hdpi)
    case hdpi
    
    /// Medium density (mdpi)
    case mdpi
    
    /// Extra-high density (xhdpi)
    case xhdpi
    
    /// Extra-extra-high density (xxhdpi)
    case xxhdpi
    
    /// Extra-extra-extra-high density (xxxhdpi)
    case xxxhdpi
}

extension AndroidSize {
    /// The default pixel size corresponding to the Android density.
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
