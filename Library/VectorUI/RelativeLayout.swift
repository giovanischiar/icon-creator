/// A layout container that encapsulates child elements and positions them relative to each other or the layout bounds (implementation for relative positioning not yet included).
struct RelativeLayout: Tag {
    private let width: Double
    private let height: Double
    private let content: [any Tag]
    private var path: Path
    
    /// Initializes a squared empty RelativeLayout.
    /// - Parameter size: The size of the square.
    init(size: Double) {
        self.init(width: size, height: size)
    }
    
    /// Initializes a squared RelativeLayout with content.
    /// - Parameters:
    ///   - size: The size of the layout.
    ///   - content: The content of the layout (elements conforming to the `Tag` protocol).
    init(size: Double, @TagBuilder content: () -> [any Tag]) {
        self.init(width: size, height: size, content: content)
    }

    /// Initializes an empty RelativeLayout.
    /// - Parameters:
    ///   - width: The width of the layout.
    ///   - height: The height of the layout.
    init(width: Double, height: Double) {
        self.init(width: width, height: height) { [] as [any Tag] }
    }
    
    /// Initializes a RelativeLayout with specified dimensions and content.
    /// - Parameters:
    ///   - width: The width of the layout.
    ///   - height: The height of the layout.
    ///   - content: The content of the layout (elements conforming to the Tag protocol).
    init(width: Double, height: Double, @TagBuilder content: () -> [any Tag]) {
        self.width = width
        self.height = height
        self.content = content()
        path = Path().d(RectPathData(x: 0, y: 0, width: width, height: height))
    }
    
    /// The body of the layout, defining the rendering order.
    var body: [any Tag] {
        path
        content
    }
}
