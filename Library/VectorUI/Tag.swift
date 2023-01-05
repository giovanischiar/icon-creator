//
//  Tag.swift
//
//
//  Created by Giovani Schiar on 05/12/22.
//

protocol Tag: Scaled, Centralized {
    var scaleFactor: Double { get set }
    var parentCoordinates: (Double, Double) { get set }
    var parentDimension: Dimension { get set }
    @TagBuilder var body: [any Tag] { get }
    func name(xmlType: XMLType) -> String
    func params(xmlType: XMLType) -> String
    func decode(xmlType: XMLType) -> String
}

extension Tag {
    var scaleFactor: Double { get {1.0} set {} }
    var parentCoordinates: (Double, Double) { get { return (0, 0) } set {} }
    var parentDimension: Dimension { get {return Dimension(width: 0, height: 0)} set {} }
    
    func name(xmlType: XMLType) -> String { return ""  }
    func params(xmlType: XMLType) -> String { return "" }
}

extension Tag {
    func decode(xmlType: XMLType) -> String {
        let name = name(xmlType: xmlType)
        let params = params(xmlType: xmlType)
        let content = body.map { "\($0.decode(xmlType: xmlType))" }.joined(separator: "")
        if (name == "" || name.starts(with: "#") || name == "root") { return content }
        return "<\(name)\(params.isEmpty ? "" : " \(params)")\(!content.isEmpty ? ">\(content)</\(name)>" : "/>")"
    }
}

extension Tag {
    func parentCoordinates(_ value: (Double, Double)) -> [any Tag] {
        if var path = self as? Path {
            path = path.parentCoordinates(value)
            return [path]
        }
        return self.body.flatMap { $0.parentCoordinates(value) }
    }

    func parentDimension(_ value: Dimension) -> [any Tag] {
        if var path = self as? Path {
            path = path.parentDimension(value)
            return [path]
        }
        return self.body.flatMap { $0.parentDimension(value) }
    }
    
    func moved(x: Double, y: Double) -> [any Tag] {
        if var path = self as? Path {
            path = path.moved(x: x, y: y)
            return [path]
        }
        return self.body.flatMap { $0.moved(x: x, y: y) }
    }
    
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
            path = path.fill(color: color)
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
    func alignItemsCenter() -> [any Tag] {
        var output = self.dropFirst().flatMap { $0.center() as [any Tag] }
        output.insert(self[0], at: 0)
        return output
    }
    
    func parentCoordinates(_ value: (Double, Double)) -> [any Tag] {
        return flatMap { $0.parentCoordinates(value) }
    }
    
    func parentDimension(_ value: Dimension) -> [any Tag] {
        return flatMap { $0.parentDimension(value) }
    }
    
    func moved(x: Double, y: Double) -> [any Tag] {
        return flatMap { $0.moved(x: x, y: y) as [any Tag] }
    }
    
    func center() -> [any Tag] {
        return flatMap {
            if($0 as? Div != nil) {
               return ($0 as! Div).center() as [any Tag]
            }
           return $0.center() as [any Tag]
        }
    }
    
    func scaled(factor: Double) -> [any Tag] {
        return flatMap { $0.scaled(factor: factor) as [any Tag] }
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
