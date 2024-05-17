//
//  Vector.swift
//
//
//  Created by Giovani Schiar on 06/12/22.
//

/// Represents the outermost element of an SVG or Vector Drawable document.
struct Vector: Tag {
    private var viewBox: [Double]
    private var content: [any Tag]
    
    /// Initializes a new `Vector` element with a specified view box and content.
    /// - Parameters:
    ///   - viewBox: A list of four `Double` values representing the view box coordinates (x, y, width, height).
    ///   - content: A closure that builds the content elements to be included within the vector element using TagBuilder syntax.
    init(viewBox: [Double], @TagBuilder content: () -> [any Tag]) {
        self.viewBox = viewBox
        self.content = content()
            .parentCoordinates((0, 0))
            .parentDimension(Dimension(width: viewBox[2], height: viewBox[3]))
    }
    
    
    /// The collection of content elements within the vector.
    var body: [any Tag] { content }
    
    /// Returns the appropriate tag name based on the provided XML type (".svg" or ".vectordrawable").
    /// - Parameter xmlType: The target XML type (`SVGType` or `VectorDrawableType`).
    /// - Returns: The vector element name corresponding to the XML type (e.g., "svg" or "vector").
    func name(xmlType: XMLType) -> String { xmlType.vector }
    
    /// Generates a string representation of the path attributes for the vector element according to the specified XML type.
    /// - Parameter xmlType: The target XML type (`SVGType` or `VectorDrawableType`).
    /// - Returns: A string containing key-value pairs representing the path attributes in the specified XML format.
    func params(xmlType: XMLType) -> String {
        var dict = [String: Any]()
        dict = dict.merging(xmlType.viewBox(values: viewBox)) { (_, new) in new }
        dict[xmlType.xmlns] = xmlType.namespace

        return dict.map { (key: String, value: Any) in
            "\(key)=\"\(value)\""
        }.lazy.joined(separator: " ")
    }
}
