//
//  Background.swift
//
//
//  Created by Giovani Schiar on 16/12/22.
//

/// It is used as a base for the background of an icon.
struct Background: Tag {
    private let width: Double
    private let height: Double
    private let content: [any Tag]
    private var path: Path
    
    /// Initializes the struct to create a square background.
    /// - Parameter size: The size of the background.
    init(size: Double) {
        self.init(width: size, height: size)
    }
    
    /// Initializes the struct to create a square background with content.
    /// - Parameters:
    ///   - size: The size of the background.
    ///   - content: The content elements to be placed on the background.
    init(size: Double, @TagBuilder content: () -> [any Tag]) {
        self.init(width: size, height: size, content: content)
    }
    
    /// Initializes the struct with a specific width and height.
    /// - Parameters:
    ///   - width: The width of the background.
    ///   - height: The height of the background.
    init(width: Double, height: Double) {
        self.init(width: width, height: height) { [] as [any Tag] }
    }
    
    /// Initializes the struct with a specific width and height with content.
    /// - Parameters:
    ///   - width: The width of the background.
    ///   - height: The height of the background.
    ///   - content: The content elements to be placed on the background.
    init(width: Double, height: Double, @TagBuilder content: () -> [any Tag]) {
        self.width = width
        self.height = height
        self.content = content()
        path = Path().d(RectPathData(x: 0, y: 0, width: width, height: height))
    }
    
    /// The elements that make up the content of the background.
    @TagBuilder var contentBody: [any Tag] {
        path
        content
    }
    
    /// The entire background element with its content.
    var body: [any Tag] {
        Vector(viewBox: [0, 0, width, height]) {
            contentBody
        }
    }
}

extension Background {
    /// Fills the background with a specified color.
    /// - Parameter color: A valid hex color string starting with "#" (e.g., "#FF0000" for red, "#FFFFFF" for white, or "#AABBDD" for a custom color with alpha).
    /// - Returns: A new background instance with the specified color fill.
    func fill(color: String) -> Background {
        var background = self
        let path = background.path
        background.path = path.fill(color: color)
        return background
    }
    
    /// Rounds the corners of the background with a specified radius.
    /// - Parameter value: The radius value used to round the corners.
    /// - Returns: A new background instance with rounded corners.
    func radius(_ value: Double) -> Background {
        var background = self
        let path = background.path
        if let rectPathData = path.data as? RectPathData {
            background.path.data = rectPathData.radius(value)
        }
        return background
    }
}
