//
//  Tag.swift
//
//
//  Created by Giovani Schiar on 05/12/22.
//

/// A protocol that characterizes a Tag element for UI or drawing purposes.
protocol Tag: Scaled, Centralized {
    /// The value used to scale the entire tag element.
    /// Defaults to 1.0 (no scaling).
    var scaleFactor: Double { get set }
    
    /// The coordinates of the parent element.
    /// Defaults to (0, 0) (top-left corner).
    var parentCoordinates: (Double, Double) { get set }
    
    /// The dimensions of the parent element.
    /// Defaults to a `Dimension` with width and height set to 0.
    var parentDimension: Dimension { get set }
    
    /// The content of the tag, potentially containing nested Tag elements.
    @TagBuilder var body: [any Tag] { get }
    
    
    /// Returns the tag name as a string based on the provided XML type (e.g., ".svg" or ".vectordrawable").
    /// - Parameter xmlType: The XML type (either .svg or .vectordrawable).
    /// - Returns: The tag name according to the XML type (e.g., "path").
    func name(xmlType: XMLType) -> String

    /// Returns a string representation of the path attributes formatted according to the specified XML type.
    /// - Parameter xmlType: The XML type (either .svg or .vectordrawable).
    /// - Returns: A string containing key-value pairs representing the path attributes in the specified XML format.
    func params(xmlType: XMLType) -> String
    
    /// Returns the XML code for this tag element based on the specified XML type.
    /// - Parameter xmlType: The XML type (either .svg or .vectordrawable).
    /// - Returns: The XML code according to the XML type.
    func decode(xmlType: XMLType) -> String
}

extension Tag {
    /// The value used to scale the entire tag element.
    /// Defaults to 1.0 (no scaling).
    var scaleFactor: Double { get {1.0} set {} }
    
    /// The coordinates of the parent element.
    /// Defaults to (0, 0) (top-left corner).
    var parentCoordinates: (Double, Double) { get { return (0, 0) } set {} }
    
    /// The dimensions of the parent element.
    /// Defaults to a `Dimension` with width and height set to 0.
    var parentDimension: Dimension { get {return Dimension(width: 0, height: 0)} set {} }
    
    /// Returns the tag name as a string based on the provided XML type (e.g., ".svg" or ".vectordrawable").
    /// By default, returns an empty string, which might not generate a valid XML element during encoding.
    /// - Parameter xmlType: The XML type (either .svg or .vectordrawable).
    /// - Returns: The tag name according to the XML type (e.g., "path").
    func name(xmlType: XMLType) -> String { return ""  }
    
    /// Returns a string representation of the path attributes formatted according to the specified XML type.
    /// By default, returns an empty string, which might not include any attributes in the generated XML.
    /// - Parameter xmlType: The XML type (either .svg" or ".vectordrawable").
    /// - Returns: A string containing key-value pairs representing the path attributes in the specified XML format.
    func params(xmlType: XMLType) -> String { return "" }
}

extension Tag {
    /// Returns the XML code for this tag element based on the specified XML type.
    /// - Parameter xmlType: The XML type (either .svg or .vectordrawable).
    /// - Returns: The XML code according to the XML type.
    func decode(xmlType: XMLType) -> String {
        let name = name(xmlType: xmlType)
        let params = params(xmlType: xmlType)
        let content = body.map { "\($0.decode(xmlType: xmlType))" }.joined(separator: "")
        if (name == "" || name.starts(with: "#") || name == "root") { return content }
        return "<\(name)\(params.isEmpty ? "" : " \(params)")\(!content.isEmpty ? ">\(content)</\(name)>" : "/>")"
    }
}

extension Tag {
    /// Sets the coordinates of the parent element for this tag and all its descendants.
    /// - Parameter value: The new parent coordinates as a tuple of (Double, Double).
    /// - Returns: A list of tags containing this tag with the updated parent coordinates applied recursively to its descendants.
    func parentCoordinates(_ value: (Double, Double)) -> [any Tag] {
        if var path = self as? Path {
            path = path.parentCoordinates(value)
            return [path]
        }
        return self.body.flatMap { $0.parentCoordinates(value) }
    }

    /// Sets the dimensions of the parent element for this tag and all its descendants.
    /// - Parameter value: The new parent dimension as a `Dimension` object.
    /// - Returns: A list of tags containing this tag with the updated parent dimensions applied recursively to its descendants.
    func parentDimension(_ value: Dimension) -> [any Tag] {
        if var path = self as? Path {
            path = path.parentDimension(value)
            return [path]
        }
        return self.body.flatMap { $0.parentDimension(value) }
    }
    
    /// Moves the path data of this tag (assumed to be a `Path`) and all its descendants by a specified offset.
    /// - Parameters:
    ///   - x: A Double value representing the offset in the x-direction.
    ///     - Positive values move the path to the right.
    ///     - Negative values move it to the left.
    ///   - y: A Double value representing the offset in the y-direction.
    ///     - Positive values move the path down.
    ///     - Negative values move it up.
    /// - Returns: A list of tags containing this tag (as a moved Path) and its descendants with the applied offset.
    func moved(x: Double, y: Double) -> [any Tag] {
        if var path = self as? Path {
            path = path.moved(x: x, y: y)
            return [path]
        }
        return self.body.flatMap { $0.moved(x: x, y: y) }
    }
    
    /// Centers all `Tag` elements within the body of this tag.
    /// - Returns: A list of tags containing this tag and its descendants, all centered within their parent element.
    func center() -> [any Tag] {
        if var path = self as? Path {
            path = path.center()
            return [path]
        }
        return self.body.flatMap {
            if ($0 as? Div != nil) {
               return ($0 as! Div).center() as [any Tag]
            }
            
            return $0.center()
        }
        
//        var tagArray = self.body
//        var tagCentered: any Tag
//        if var path = self as? Path {
//            path = path.center()
//            return [path]
//        }
//        tagCentered = tagArray[0].center()[0]
//        tagArray[0] = tagCentered
//        return tagArray
    }
    
    /// Scales the path data of this tag (assumed to be a `Path`) by a specified factor.
    /// - Parameter factor: A Double value representing the scaling factor.
    ///   - A value of 1.0 maintains the current size.
    ///   - Values greater than 1.0 scale the path up.
    ///   - Values less than 1.0 scale the path down.
    /// - Returns: A list of tags containing this tag (as a scaled Path) and its descendants with the applied scaling factor.
    func scaled(factor: Double) -> [any Tag] {
        var tagArray = self.body
        var tagScaleChanged: any Tag
        if var path = self as? Path {
            path = path.scaled(factor: factor)
            return [path]
        }
        tagScaleChanged = tagArray[0].scaled(factor: factor)[0]
        tagArray[0] = tagScaleChanged
        return tagArray
    }
    
    /// Fills the background of this tag with a specified color.
    /// - Parameter color: A valid hex color string representing the fill color.
    /// - Returns: A new list of tags containing this tag with the specified background color applied. The original tags within the body remain unmodified.
    func fill(color: String) -> [any Tag] {
        var tagArray = self.body
        var tagFillColorChanged: any Tag
        if var path = self as? Path {
            path = path.fill(color: color)
            return [path]
        }
        tagFillColorChanged = tagArray[0].fill(color: color)[0]
        tagArray[0] = tagFillColorChanged
        return tagArray
    }
    
    /// Changes the width of the border (stroke) around a `Tag` element.
    /// - Parameter width: The new width of the stroke (border).
    /// - Returns: A new list of tags containing this tag with the specified stroke width applied to the first `Tag` descendant (if present). The original tags within the body remain unmodified.
    func stroke(width: Double) -> [any Tag] {
        var tagArray = self.body
        var tagStrokeWidthChanged: any Tag
        if var path = self as? Path {
            path = path.stroke(width: width)
            return [path]
        }
        tagStrokeWidthChanged = tagArray[0].stroke(width: width)[0]
        tagArray[0] = tagStrokeWidthChanged
        return tagArray
    }
    
    /// Changes the color of the border (stroke) around this tag.
    /// - Parameter color: A valid hex color string representing the new stroke color.
    /// - Returns: A new list of tags containing this tag with the specified stroke color applied. The original tags within the body remain unmodified (similar to `fill`).
    func stroke(color: String) -> [any Tag] {
        var tagArray = self.body
        var tagColorFilledChanged: any Tag
        if var path = self as? Path {
            path = path.stroke(color: color)
            return [path]
        }
        tagColorFilledChanged = tagArray[0].stroke(color: color)[0]
        tagArray[0] = tagColorFilledChanged
        return tagArray
    }

    /// Changes the stroke of the border (stroke) line join around this tag.
    /// - Parameter join: A valid hex color string representing the new stroke color.
    /// - Returns: A new list of tags containing this tag with the specified stroke line join applied. The original tags within the body remain unmodified (similar to `fill`).
    func strokeLine(join: String) -> [any Tag] {
        var tagArray = self.body
        var tagColorStrokeLineJoinChanged: any Tag
        if var path = self as? Path {
            path = path.strokeLine(join: join)
            return [path]
        }
        tagColorStrokeLineJoinChanged = tagArray[0].strokeLine(join: join)[0]
        tagArray[0] = tagColorStrokeLineJoinChanged
        return tagArray
    }

    /// Changes the stroke of the border (stroke) line cap around this tag.
    /// - Parameter cap: A valid hex color string representing the new stroke line cap.
    /// - Returns: A new list of tags containing this tag with the specified stroke line cap applied. The original tags within the body remain unmodified (similar to `fill`).
    func strokeLine(cap: String) -> [any Tag] {
        var tagArray = self.body
        var tagColorStrokeLineCapChanged: any Tag
        if var path = self as? Path {
            path = path.strokeLine(cap: cap)
            return [path]
        }
        tagColorStrokeLineCapChanged = tagArray[0].strokeLine(cap: cap)[0]
        tagArray[0] = tagColorStrokeLineCapChanged
        return tagArray
    }
}

extension [Tag] {
    /// Aligns all `Tag` elements in the list to the center, except for the first element.
    /// - Returns: A new list of `Tag` elements with all elements except the first centered within their parent.
    func alignItemsCenter() -> [any Tag] {
        var output = self.dropFirst().flatMap { $0.center() as [any Tag] }
        output.insert(self[0], at: 0)
        return output
    }
    
    /// Sets the parent coordinates for all `Tag` elements in the list.
    /// - Parameter value: The new parent coordinates as a tuple of (Double, Double).
    /// - Returns: A new list of `Tag` elements with the updated parent coordinates applied to each element.
    func parentCoordinates(_ value: (Double, Double)) -> [any Tag] {
        return flatMap { $0.parentCoordinates(value) }
    }
    
    /// Sets the parent dimension for all `Tag` elements in the list.
    /// - Parameter value: The new parent dimension as a `Dimension` object.
    /// - Returns: A new list of `Tag` elements with the updated parent dimensions applied to each element.
    func parentDimension(_ value: Dimension) -> [any Tag] {
        return flatMap { $0.parentDimension(value) }
    }
    
    /// Moves the path data of all `Tag` elements (assumed to be `Path` types) in the list by a specified offset.
    /// - Parameters:
    ///   - x: A Double value representing the offset in the x-direction.
    ///     - Positive values move the path to the right.
    ///     - Negative values move it to the left.
    ///   - y: A Double value representing the offset in the y-direction.
    ///     - Positive values move the path down.
    ///     - Negative values move it up.
    /// - Returns: A new list of `Tag` elements with the path data of each element (assumed to be a `Path`) moved by the specified offset.
    func moved(x: Double, y: Double) -> [any Tag] {
        return flatMap { $0.moved(x: x, y: y) as [any Tag] }
    }
    
    /// Centers all `Tag` elements in the list.
    /// - Returns: A new list of `Tag` elements with all elements centered within their parent.
    func center() -> [any Tag] {
        return flatMap {
            if($0 as? Div != nil) {
               return ($0 as! Div).center() as [any Tag]
            }
           return $0.center() as [any Tag]
        }
    }
    
    /// Scales the path data of all `Tag` elements (assumed to be `Path` types) in the list by a specified factor.
    /// - Parameter factor: A Double value representing the scaling factor.
    ///   - A value of 1.0 maintains the current size.
    ///   - Values greater than 1.0 scale the path up.
    ///   - Values less than 1.0 scale the path down.
    /// - Returns: A new list of `Tag` elements with the path data of each element (assumed to be a `Path`) scaled by the specified factor.
    func scaled(factor: Double) -> [any Tag] {
        return flatMap { $0.scaled(factor: factor) as [any Tag] }
    }
    
    /// Fills the background of the tags with a specified color.
    /// - Parameter color: A valid hex color string representing the fill color.
    /// - Returns:The Tag list with the specified background color.
    func fill(color: String) -> [any Tag] {
        var tagArray = self
        let tagColorFilledChanged = tagArray[0].fill(color: color)
        tagArray[0] = tagColorFilledChanged[0]
        return tagArray
    }
    
    /// Changes the width of the border (stroke) around the first `Tag` element in the list.
     /// - Parameter width: The new width of the stroke (border).
     /// - Returns: A new list of `Tag` elements with the specified stroke width applied to the first `Tag` element (if present).
    func stroke(width: Double) -> [any Tag] {
        var tagArray = self
        let tagStrokeWidthChanged = tagArray[0].stroke(width: width)
        tagArray[0] = tagStrokeWidthChanged[0]
        return tagArray
    }
    
    /// Changes the color of the border (stroke) around the first `Tag` element in the list.
    /// - Parameter color: A valid hex color string representing the new stroke color.
    /// - Returns: A new list of `Tag` elements with the specified stroke color applied to the first element.
    func stroke(color: String) -> [any Tag] {
        var tagArray = self
        let tagStrokeColorChanged = tagArray[0].stroke(color: color)
        tagArray[0] = tagStrokeColorChanged[0]
        return tagArray
    }
}
