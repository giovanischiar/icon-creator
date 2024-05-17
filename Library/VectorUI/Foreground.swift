//
//  Background.swift
//
//
//  Created by Giovani Schiar on 17/12/22.
//

/// A base element used as a foreground for icons.
struct Foreground: Tag {
    private let x: Double
    private let y: Double
    private let width: Double
    private let height: Double
    private var content: [any Tag]
    
    /// The scale factor applied to the entire foreground element.
    var scaleFactor = 1.0
    
    /// Initializes a square foreground with no content provided.
    /// - Parameter size: The size of the square foreground.
    init(size: Double) { self.init(x: 0.0, y: 0.0, width: size, height: size) {} }
    
    /// Initializes a square foreground with a specified position and optional content.
    /// - Parameters:
    ///   - x: The x coordinate of the foreground.
    ///   - y: The y coordinate of the foreground.
    ///   - size: The size of the square foreground.
    ///   - content: The optional content elements to be displayed on the foreground.
    init(x: Double, y: Double, size: Double, @TagBuilder content: () -> [any Tag]) {
        self.init(x: x, y: y, width: size, height: size, content: content)
    }
    
    /// Initializes a square foreground with content provided.
    /// - Parameters:
    ///   - size: The size of the square foreground.
    ///   - content: The content elements to be displayed on the foreground.
    init(size: Double, @TagBuilder content: () -> [any Tag]) {
        self.init(x: 0.0, y: 0.0, width: size, height: size, content: content)
    }
    
    /// Initializes a rectangular foreground with no content provided.
    /// - Parameters:
    ///   - width: The width of the rectangular foreground.
    ///   - height: The height of the rectangular foreground.
    init(width: Double, height: Double) {
        self.init(x: 0.0, y: 0.0, width: width, height: height) {}
    }
    
    /// Initializes a rectangular foreground with a specified position, dimensions, and optional content.
    /// - Parameters:
    ///   - x: The x coordinate of the foreground.
    ///   - y: The y coordinate of the foreground.
    ///   - width: The width of the rectangular foreground.
    ///   - height: The height of the rectangular foreground.
    ///   - content: The optional content elements to be displayed on the foreground (optional).
    init(x: Double, y: Double, width: Double, height: Double, @TagBuilder content: () -> [any Tag]) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.content = content()
            .parentCoordinates((x, y))
            .parentDimension(Dimension(width: width, height: height))
    }
    
    /// The child elements that make up the content displayed on top of the foreground.
    @TagBuilder var contentBody: [any Tag] {
        content
    }
    
    /// The entire foreground element with its content wrapped in a Vector element with a viewBox set to the foreground's dimensions.
    var body: [any Tag] {
        Vector(viewBox: [x, y, width, height]) {
            contentBody
        }
    }
}

extension Foreground {
    /// Scales the entire foreground element, including its content, by a specified factor.
    /// - Parameter factor: The scaling factor. A value of 1.0 maintains the original size, values greater than 1.0 increase the size, and values less than 1.0 decrease the size.
    /// - Returns: A new Foreground element with the applied scaling.
    func scaled(factor: Double) -> Foreground {
        var foreground = self
        foreground.scaleFactor = factor
        foreground.content = foreground.content.scaled(factor: factor)
        return foreground
    }
    
    /// Aligns the content elements within the foreground to the center.
    /// - Returns: A new Foreground element with its content centered.
    func center() -> Foreground {
        var foreground = self
        foreground.content = foreground.content.center()
        return foreground
    }
    
    /// Sets the dimensions of the parent container used for some internal calculations within the Div element.
    /// - Parameter value: The dimension (width and height) of the parent container.
    /// - Returns: The foreground with the specified parent dimension set.
    func parentDimension(_ value: Dimension) -> Foreground {
        var foreground = self
        foreground.content = foreground.parentDimension(value)
        return foreground
    }
}
