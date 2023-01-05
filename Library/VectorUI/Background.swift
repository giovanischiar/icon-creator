//
//  Background.swift
//
//
//  Created by Giovani Schiar on 16/12/22.
//

struct Background: Tag {
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
    
    @TagBuilder var contentBody: [any Tag] {
        path
        content
    }
    
    var body: [any Tag] {
        Vector(viewBox: [0, 0, width, height]) {
            contentBody
        }
    }
}

extension Background {
    func fill(color: String) -> Background {
        var background = self
        let path = background.path
        background.path = path.fill(color: color)
        return background
    }
    
    func radius(_ value: Double) -> Background {
        var background = self
        let path = background.path
        if let rectPathData = path.data as? RectPathData {
            background.path.data = rectPathData.radius(value)
        }
        return background
    }
}
