//
//  Background.swift
//
//
//  Created by Giovani Schiar on 17/12/22.
//

struct Foreground: Tag {
    let x: Double
    let y: Double
    let width: Double
    let height: Double
    var content: [any Tag]
    var scaleFactor = 1.0
    
    init(size: Double) { self.init(x: 0.0, y: 0.0, width: size, height: size) {} }
    
    init(x: Double, y: Double, size: Double, @TagBuilder content: () -> [any Tag]) {
        self.init(x: x, y: y, width: size, height: size, content: content)
    }
    
    init(size: Double, @TagBuilder content: () -> [any Tag]) {
        self.init(x: 0.0, y: 0.0, width: size, height: size, content: content)
    }
    
    init(width: Double, height: Double) {
        self.init(x: 0.0, y: 0.0, width: width, height: height) {}
    }
    
    init(x: Double, y: Double, width: Double, height: Double, @TagBuilder content: () -> [any Tag]) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.content = content()
            .parentCoordinates((x, y))
            .parentDimension(Dimension(width: width, height: height))
    }
    
    @TagBuilder var contentBody: [any Tag] {
        content
    }
    
    var body: [any Tag] {
        Vector(viewBox: [x, y, width, height]) {
            contentBody
        }
    }
}

extension Foreground {
    func scaled(factor: Double) -> Foreground {
        var foreground = self
        foreground.scaleFactor = factor
        foreground.content = foreground.content.scaled(factor: factor)
        return foreground
    }
    
    func center() -> Foreground {
        var foreground = self
        foreground.content = foreground.content.center()
        return foreground
    }
    
    func parentDimension(_ value: Dimension) -> Foreground {
        var foreground = self
        foreground.content = foreground.parentDimension(value)
        return foreground
    }
}
