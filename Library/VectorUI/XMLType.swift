//
//  XMLType.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

/// The representation of supported XML types.
enum XMLType {
    /// Scalable Vector Graphics (SVG). Typically used to generate various sizes on iOS.
    case svg
    
    /// Vector Drawable format supported by Android.
    case vectordrawable
}

extension XMLType {
    /// Generates a dictionary containing the view box parameters.
    /// - Parameter values: An optional array of doubles representing the view box values.
    /// - Returns: A dictionary containing the view box parameters (`["viewBox": String]`).
    func viewBox(values: [Double]?) -> [String: Any] {
        switch(self) {
            case .svg:
                var dict = [:] as [String: Any]
                let viewBoxString = values != nil ? (values ?? []).stringArray.joined(separator: " ") : ""
                dict["viewBox"] = viewBoxString
                if (viewBoxString == "") { dict["viewBox"] = nil }
                return dict
            case .vectordrawable:
                var dict = [:] as [String: Any]
                let viewBoxStrings = values?.stringArray ?? [] as [String]
                let width = viewBoxStrings.count == 4 ? "\(viewBoxStrings[2])" : nil
                let height = viewBoxStrings.count == 4 ? "\(viewBoxStrings[3])" : nil
                dict["android:viewportWidth"] = width
                dict["android:viewportHeight"] = height
                dict[self.width] = width != nil ? "\(width!)dp" : nil
                dict[self.height] = height != nil ? "\(height!)dp": nil
                return dict
        }
    }
}


extension XMLType {
    /// The namespace URI according to the type.
    var namespace: String {
        switch(self) {
            case .svg: return "http://www.w3.org/2000/svg"
            case .vectordrawable: return "http://schemas.android.com/apk/res/android"
        }
    }
}

extension XMLType {
    /// The path tag acoording with the type.
    var path: String {
        switch(self) {
            case .svg, .vectordrawable: return "path"
        }
    }
    
    /// The tag name for the vector element according to the type.
    var vector: String {
        switch(self) {
            case .svg: return "svg"
            case .vectordrawable: return "vector"
        }
    }
    
    /// The attribute name for the xmlns namespace declaration according to the type.
    var xmlns: String {
        switch(self) {
            case .svg: return "xmlns"
            case .vectordrawable: return "xmlns:android"
        }
    }
    
    /// The attribute name for the path data geometry according to the type.
    var d: String {
        switch(self) {
            case .svg: return "d"
            case .vectordrawable: return "android:pathData"
        }
    }
    
    /// The attribute name for the stroke color according to the type.
    var strokeColor: String {
        switch(self) {
            case .svg: return "stroke"
            case .vectordrawable: return "android:strokeColor"
        }
    }
    
    /// The attribute name for the stroke width according to the type.
    var strokeWidth: String {
        switch(self) {
            case .svg: return "stroke-width"
            case .vectordrawable: return "android:strokeWidth"
        }
    }
    
    /// The attribute name for the fill color according to the type.
    var fill: String {
        switch(self) {
            case .svg: return "fill"
            case .vectordrawable: return "android:fillColor"
        }
    }
    
    /// The attribute name for the fill opacity according to the type.
    var fillOpacity: String {
        switch(self) {
            case .svg: return "fill-opacity"
            case .vectordrawable: return "android:fillOpacity"
        }
    }
    
    /// The attribute name for the width according to the type.
    var width: String {
        switch(self) {
            case .svg: return "width"
            case .vectordrawable: return "android:width"
        }
    }
    
    /// The attribute name for the height according to the type.
    var height: String {
        switch(self) {
            case .svg: return "height"
            case .vectordrawable: return "android:height"
        }
    }

    /// The attribute name for the stroke line join according to the type.
    var strokeLineJoin: String {
        switch(self) {
            case .svg: return "stroke-linejoin"
            case .vectordrawable: return "android:strokeLineJoin"
        }
    }

    /// The attribute name for the stroke line cap according to the type.
    var strokeLineCap: String {
        switch(self) {
            case .svg: return "stroke-linecap"
            case .vectordrawable: return "android:strokeLineCap"
        }
    }
}
