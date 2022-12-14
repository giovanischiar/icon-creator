//
//  Path.swift
//
//
//  Created by Giovani Schiar on 06/12/22.
//

struct Path: BodylessTag {
    var data: PathDatable = PathData(commands: [])
    var strokeWidth: Double = 0.0  {
        didSet { data.move(x: strokeWidth/2, y: strokeWidth/2) }
    }
    var strokeColor: String? = nil
    var fill: String? = nil
    var fillOpacity: Double? = nil
    var parentDimension: Dimension? = nil
    
    func name(xmlType: XMLType) -> String { xmlType.path }
    
    func params(xmlType: XMLType) -> String {
        var dict = [String: Any]()
        dict[xmlType.d] = data
        dict[xmlType.strokeWidth] = strokeWidth
        dict[xmlType.strokeColor] = strokeColor
        dict[xmlType.fill] = fill
        if (xmlType == .svg) {
            dict[xmlType.fillOpacity] = fillOpacity != nil ? fillOpacity : (fill != nil ? 1 : 0)
        }
        return dict.map { (key: String, value: Any) in
            "\(key)=\"\(value)\""
        }.lazy.joined(separator: " ")
    }
}

extension Path {
    func d(_ data: PathDatable) -> Path {
        var path = self
        path.data = data
        return path
    }
    
    func stroke(width: Double) -> Path {
        var path = self
        path.strokeWidth = width
        return path
    }
    
    func stroke(color: String) -> Path {
        var path = self
        path.strokeColor = color
        return path
    }
    
    func fill(with color: String) -> Path {
        var path = self
        path.fill = color
        return path
    }
    
    func fill(opacity: Double) -> Path {
        var path = self
        path.fillOpacity = opacity
        return path
    }
    
    func center() -> Path {
        var newData = data
        newData.centralize()
        var path = self
        path.data = newData
        return path
    }
}

extension Path: Scaled, Moved {
    func scaled(factor: Double) -> Path {
        var pathTag = self
        pathTag.data.scale(factor: factor)
        return pathTag
    }

    func moved(x: Double, y: Double) -> Path {
        var pathTag = self
        pathTag.data.move(x: x, y: y)
        return pathTag
    }
}
