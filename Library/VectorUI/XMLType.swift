//
//  XMLType.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

enum XMLType { case svg; case vectordrawable }

extension XMLType {
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
    var namespace: String {
        switch(self) {
            case .svg: return "http://www.w3.org/2000/svg"
            case .vectordrawable: return "http://schemas.android.com/apk/res/android"
        }
    }
}

extension XMLType {
    var path: String {
        switch(self) {
            case .svg, .vectordrawable: return "path"
        }
    }
    
    var vector: String {
        switch(self) {
            case .svg: return "svg"
            case .vectordrawable: return "vector"
        }
    }
    
    var xmlns: String {
        switch(self) {
            case .svg: return "xmlns"
            case .vectordrawable: return "xmlns:android"
        }
    }
    
    var d: String {
        switch(self) {
            case .svg: return "d"
            case .vectordrawable: return "android:pathData"
        }
    }
    
    var strokeColor: String {
        switch(self) {
            case .svg: return "stroke"
            case .vectordrawable: return "android:strokeColor"
        }
    }
    
    var strokeWidth: String {
        switch(self) {
            case .svg: return "stroke-width"
            case .vectordrawable: return "android:strokeWidth"
        }
    }
    
    var fill: String {
        switch(self) {
            case .svg: return "fill"
            case .vectordrawable: return "android:fillColor"
        }
    }
    
    var fillOpacity: String {
        switch(self) {
            case .svg: return "fill-opacity"
            case .vectordrawable: return "android:fillOpacity"
        }
    }
    
    var width: String {
        switch(self) {
            case .svg: return "width"
            case .vectordrawable: return "android:width"
        }
    }
    
    var height: String {
        switch(self) {
            case .svg: return "height"
            case .vectordrawable: return "android:height"
        }
    }
}
