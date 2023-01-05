struct RelativeLayout: Tag {
    let width: Double
    let height: Double
    let content: [any Tag]
    var path: Path
    
    init(size: Double) {
        self.init(width: size, height: size)
    }
    
    init(size: Double, @TagBuilder content: () -> [any Tag]) {
        self.init(width: size, height: size, content: content)
    }
    
    init(width: Double, height: Double) {
        self.init(width: width, height: height) { [] as [any Tag] }
    }
    
    init(width: Double, height: Double, @TagBuilder content: () -> [any Tag]) {
        self.width = width
        self.height = height
        self.content = content()
        path = Path().d(RectPathData(x: 0, y: 0, width: width, height: height))
    }
    
    var body: [any Tag] {
        path
        content
    }
}
