//
//  Div.swift
//
//
//  Created by Giovani Schiar on 19/12/22.
//

struct Div: Tag, Centralized {
    var width: Double { rectPathData.width }
    var height: Double { rectPathData.width }
    
    var content: [any Tag] = [] as [any Tag]
    var rectPathData: RectPathData = RectPathData(x: 0, y: 0, width: 0, height: 0) { didSet { path = path.d(rectPathData) } }
    var path = Path()
    
    init(@TagBuilder content: () -> [any Tag]) {
        self.content = content()
    }
    
    @TagBuilder var contentBody: [any Tag] {
        path
        content
    }
    
    var body: [any Tag] {
        contentBody
    }
}

extension Div {
    func scaled(factor: Double) -> Div {
        var div = self
        div.path = div.path.scaled(factor: factor)
        div.content = div.content.scaled(factor: factor)
        return div
    }
    
    func parentCoordinates(_ value: (Double, Double)) -> Div {
        var div = self
        div.path = div.path.parentCoordinates(value)
        return div
    }
    
    func parentDimension(_ value: Dimension) -> Div {
        var div = self
        div.path = div.path.parentDimension(value)
        div.content = div.content.parentDimension(value)
        return div
    }
    
    func alignItemsCenter() -> Div {
        var div = self
        div.content = div.content.center()
        return div
    }
    
    func center() -> Div {
        var div = self
        div.path = div.path.center()
        div.content = content.parentCoordinates((div.path.data.frame.0.0, div.path.data.frame.0.1))
        return div
    }
    
    func position(x: Double, y: Double) -> Div {
        var div = self
        let saveWidth = div.rectPathData.width
        let saveHeight = div.rectPathData.height
        div.rectPathData = RectPathData(x: x, y: y, width: saveWidth, height: saveHeight)
        div.content = content.parentCoordinates((x, y))
        return div
    }

    func northEastRadius(rx: Double) -> Div {
        var div = self
        let saveX = div.rectPathData.x
        let saveY = div.rectPathData.y
        let saveWidth = div.rectPathData.width
        let saveHeight = div.rectPathData.height

        let saveSERX = div.rectPathData.serx
        let saveSWRX = div.rectPathData.swrx
        let saveNWRX = div.rectPathData.nwrx

        div.rectPathData = RectPathData(
            x: saveX, 
            y: saveY, 
            width: saveWidth, 
            height: saveHeight,
            nerx: rx, 
            serx: saveSERX, 
            swrx: saveSWRX, 
            nwrx: saveNWRX
        )
        return div
    }

    func southEastRadius(rx: Double) -> Div {
        var div = self
        let saveX = div.rectPathData.x
        let saveY = div.rectPathData.y
        let saveWidth = div.rectPathData.width
        let saveHeight = div.rectPathData.height

        let saveNERX = div.rectPathData.nerx
        let saveSWRX = div.rectPathData.swrx
        let saveNWRX = div.rectPathData.nwrx

        div.rectPathData = RectPathData(
            x: saveX, 
            y: saveY, 
            width: saveWidth, 
            height: saveHeight,
            nerx: saveNERX, 
            serx: rx, 
            swrx: saveSWRX, 
            nwrx: saveNWRX
        )
        return div
    }

    func southWestRadius(rx: Double) -> Div {
        var div = self
        let saveX = div.rectPathData.x
        let saveY = div.rectPathData.y
        let saveWidth = div.rectPathData.width
        let saveHeight = div.rectPathData.height

        let saveNERX = div.rectPathData.nerx
        let saveSERX = div.rectPathData.serx
        let saveNWRX = div.rectPathData.nwrx

        div.rectPathData = RectPathData(
            x: saveX, 
            y: saveY, 
            width: saveWidth, 
            height: saveHeight,
            nerx: saveNERX, 
            serx: saveSERX, 
            swrx: rx, 
            nwrx: saveNWRX
        )
        return div
    }

    func northWestRadius(rx: Double) -> Div {
        var div = self
        let saveX = div.rectPathData.x
        let saveY = div.rectPathData.y
        let saveWidth = div.rectPathData.width
        let saveHeight = div.rectPathData.height

        let saveNERX = div.rectPathData.nerx
        let saveSERX = div.rectPathData.serx
        let saveSWRX = div.rectPathData.swrx

        div.rectPathData = RectPathData(
            x: saveX, 
            y: saveY, 
            width: saveWidth, 
            height: saveHeight,
            nerx: saveNERX, 
            serx: saveSERX, 
            swrx: saveSWRX, 
            nwrx: rx
        )
        return div
    }
    
    func dimension(width: Double, height: Double) -> Div {
        var div = self
        let saveX = div.rectPathData.x
        let saveY = div.rectPathData.y
        div.rectPathData = RectPathData(x: saveX, y: saveY, width: width, height: height)
        div.content = content.parentCoordinates((saveX, saveY))
        return div
    }
    
    func dimensionAlt(width: Double, height: Double) -> Div {
        var div = self
        let dimension = Dimension(width: width, height: height)
        div.rectPathData = div.rectPathData.dimension(width: width, height: width)
        div.content = content.parentDimension(dimension)
        div.path = div.path.parentDimension(dimension)
        return div
    }
    
    func stroke(width: Double) -> Div {
        var div = self
        div.path = div.path.stroke(width: width)
        return div
    }
    
    func stroke(color: String) -> Div {
        var div = self
        div.path = div.path.stroke(color: color)
        return div
    }
    
    func fill(color: String) -> Div {
        var div = self
        div.path = div.path.fill(color: color)
        return div
    }
}
