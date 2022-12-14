//
//  Tag.swift
//
//
//  Created by Giovani Schiar on 05/12/22.
//

protocol Tag: Scaled {
    @TagBuilder var body: [any Tag] { get }
    func name(xmlType: XMLType) -> String
    func params(xmlType: XMLType) -> String
    func decode(xmlType: XMLType) -> String
}

extension Tag {
    func name(xmlType: XMLType) -> String {
        return ""
    }
    
    func params(xmlType: XMLType) -> String {
        return ""
    }
}

extension Tag {
    func decode(xmlType: XMLType) -> String {
        let name = name(xmlType: xmlType)
        let params = params(xmlType: xmlType)
        let content = body.map { "\($0.decode(xmlType: xmlType))" }.joined(separator: "")
        if (name == "" || name == "root") { return content }
        return "<\(name)\(params.isEmpty ? "" : " \(params)")\(!content.isEmpty ? ">\(content)</\(name)>" : "/>")"
    }
}

extension Tag {
    func center() -> [any Tag] {
        if var path = self as? Path {
            path = path.center()
            return [path]
        }
        return self.body.flatMap { $0.center() }
        
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
    
    func fill(color: String) -> [any Tag] {
        var tagArray = self.body
        var tagFillColorChanged: any Tag
        if var path = self as? Path {
            path = path.fill(with: color)
            return [path]
        }
        tagFillColorChanged = tagArray[0].fill(color: color)[0]
        tagArray[0] = tagFillColorChanged
        return tagArray
    }
    
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
}

extension [Tag] {
    func center() -> [any Tag] {
        return flatMap { $0.center() as [any Tag] }
//        var tagArray = self
//        let tagCenterChanged = tagArray[0].center() as [any Tag]
//        tagArray[0] = tagCenterChanged[0]
//        return tagArray
    }
    
    func scaled(factor: Double) -> [any Tag] {
        return flatMap { $0.scaled(factor: factor) as [any Tag] }
        
//        var tagArray = self
//        let tagScaleChanged = tagArray[0].scaled(factor: factor) as [any Tag]
//        tagArray[0] = tagScaleChanged[0]
//        return tagArray
    }
    
    func fill(color: String) -> [any Tag] {
        var tagArray = self
        let tagColorFilledChanged = tagArray[0].fill(color: color)
        tagArray[0] = tagColorFilledChanged[0]
        return tagArray
    }
    
    func stroke(width: Double) -> [any Tag] {
        var tagArray = self
        let tagStrokeWidthChanged = tagArray[0].stroke(width: width)
        tagArray[0] = tagStrokeWidthChanged[0]
        return tagArray
    }
    
    func stroke(color: String) -> [any Tag] {
        var tagArray = self
        let tagStrokeColorChanged = tagArray[0].stroke(color: color)
        tagArray[0] = tagStrokeColorChanged[0]
        return tagArray
    }
}
