//
//  Path.swift
//
//
//  Created by Giovani Schiar on 06/12/22.
//

/// A representation of a path element, compatible with both SVG and Vector Drawable.
struct Path: BodylessTag {
    /// The value used to scale the entire path element.
    var scaleFactor = 1.0
    
    /// The coordinates of the parent container relative to which the path is positioned.
    /// These coordinates might be used for calculations or passed down to child elements.
    var parentCoordinates = (0.0, 0.0) {
        didSet {
            data.move(x: parentCoordinates.0, y: parentCoordinates.1)
        }
    }
    /// The dimensions (width and height) of the parent container.
    /// How this property is used within the Path itself is not currently specified.
    var parentDimension = Dimension(width: 0.0, height: 0.0)
    
    /// The path data defining the path geometry.
    /// This property should conform to the `PathDatable` protocol which specifies how path data is represented.
    var data: PathDatable = PathData(commands: [])
    private var strokeWidth: Double = 0.0
    
    private var isCentered = false
    private var strokeColor: String? = nil
    private var fill: String? = nil
    private var fillOpacity: Double? = nil
    private var strokeLineJoin: String? = nil
    private var strokeLineCap: String? = nil
    
    /// The name of the component based on the XML type.
    /// - Parameter xmlType: The XML type (either .svg or .vectorDrawable).
    /// - Returns: The component name according to the XML type (e.g., "path").
    func name(xmlType: XMLType) -> String { xmlType.path }
    
    /// Returns a string representation of the path attributes according to the specified XML type.
    /// - Parameter xmlType: The XML type (either .svg or .vectordrawable).
    /// - Returns: A string containing key-value pairs representing the path attributes in the specified XML format.
    func params(xmlType: XMLType) -> String {
        var dict = [String: Any]()
        dict[xmlType.d] = data
        dict[xmlType.strokeWidth] = strokeWidth
        dict[xmlType.strokeColor] = strokeColor
        dict[xmlType.fill] = fill
        dict[xmlType.strokeLineJoin] = strokeLineJoin
        dict[xmlType.strokeLineCap] = strokeLineCap
        if (xmlType == .svg) {
            dict[xmlType.fillOpacity] = fillOpacity != nil ? fillOpacity : (fill != nil ? 1 : 0)
        }
        return dict.map { (key: String, value: Any) in
            "\(key)=\"\(value)\""
        }.lazy.joined(separator: " ")
    }
}

extension Path {
    /// Changes the core path data of the `Path`.
    /// - Parameter data: A new `PathDatable` object representing the desired path geometry.
    /// - Returns: A new `Path` object with the updated path data.
    func d(_ data: PathDatable) -> Path {
        var path = self
        path.data = data
        return path
    }
    
    /// Changes the width of the path stroke.
    /// - Parameter width: The new width of the stroke in user units (a Double value).
    /// - Returns: A new `Path` object with the updated stroke width.
    func stroke(width: Double) -> Path {
        var path = self
        path.strokeWidth = width
        return path
    }
    
    /// Changes the color of the path stroke.
    /// - Parameter color: The new color of the stroke in a format specific to the target XML type (CSS color format for SVG, hex color string for Vector Drawable).
    /// - Returns: A new `Path` object with the updated stroke color.
    func stroke(color: String) -> Path {
        var path = self
        path.strokeColor = color
        return path
    }

    /// Changes the join of the path line stroke.
    /// - Parameter join: The new join of the line stroke.
    /// - Returns: A new `Path` object with the updated stroke line join.
    func strokeLine(join: String) -> Path {
        var path = self
        path.strokeLineJoin = join
        return path
    }

    /// Changes the cap of the path line stroke.
    /// - Parameter cap: The new cap of the line stroke.
    /// - Returns: A new `Path` object with the updated stroke line cap.
    func strokeLine(cap: String) -> Path {
        var path = self
        path.strokeLineCap = cap
        return path
    }

    /// Changes the fill color of the path.
    /// - Parameter color: The new color of the fill in a format specific to the target XML type (CSS color format for SVG, hex color string for Vector Drawable).
    /// - Returns: A new `Path` object with the updated fill color.
    func fill(color: String) -> Path {
        var path = self
        path.fill = color
        return path
    }
    
    /// Changes the opacity of the path fill.
    /// - Parameter opacity: The new opacity value between 0.0 (fully transparent) and 1.0 (fully opaque).
    /// - Returns: A new `Path` object with the updated fill opacity.
    func fill(opacity: Double) -> Path {
        var path = self
        path.fillOpacity = opacity
        return path
    }
    
    /// Center the path within its parent.
    /// - Returns: The Path Centralized inside the parent.
    func center() -> Path {
        if (self.isCentered) { return self }
        var newData = data
        newData.centralize(parentDimension: parentDimension)
        var path = self
        path.data = newData
        path.isCentered = true
        return path
    }
    
    /// Set the Parent dimension.
    /// - Parameter value: The parent's dimension.
    /// - Returns: The Path with the parent's dimension.
    func parentDimension(_ value: Dimension) -> Path {
        var path = self
        path.parentDimension = value
        return path
    }
    
    /// Set the Parent coordinate.
    /// - Parameter value: The parent's coordinate.
    /// - Returns: The Path with the parent's coordinate.
    func parentCoordinates(_ value: (Double, Double)) -> Path {
        var path = self
        path.parentCoordinates = value
        return path
    }
}

extension Path: Scaled, Moved {
    /// Scales the path data of the Path object by a specified factor.
    /// - Parameter factor: A Double value representing the scaling factor.
    ///   - A value of 1.0 maintains the current size.
    ///   - Values greater than 1.0 scale the path up.
    ///   - Values less than 1.0 scale the path down.
    /// - Returns: A new Path object with the scaled path data.
    func scaled(factor: Double) -> Path {
        var pathTag = self
        pathTag.data.scale(factor: factor)
        return pathTag
    }
    
    /// Moves the path data of the Path object by a specified offset.
    /// - Parameters:
    ///   - x: A Double value representing the offset in the x-direction.
    ///     - Positive values move the path to the right.
    ///     - Negative values move it to the left.
    ///   - y: A Double value representing the offset in the y-direction.
    ///     - Positive values move the path down.
    ///     - Negative values move it up.
    /// - Returns: A new Path object with the moved path data.
    func moved(x: Double, y: Double) -> Path {
        var pathTag = self
        pathTag.data.move(x: x, y: y)
        return pathTag
    }
}
