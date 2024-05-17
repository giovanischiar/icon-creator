//
//  Div.swift
//
//
//  Created by Giovani Schiar on 19/12/22.
//

/// A base tag similar to the HTML "div" element, used to encapsulate components within a rectangle or a rounded rectangle (when setting a radius).
struct Div: Tag, Centralized {
    private var width: Double { rectPathData.width }
    private var height: Double { rectPathData.width }
    
    private var content: [any Tag] = [] as [any Tag]
    private var rectPathData: RectPathData = RectPathData(x: 0, y: 0, width: 0, height: 0) { didSet { path = path.d(rectPathData) } }
    private var path = Path()
    
    /// Initializes the Div element.
    /// - Parameter content: The content elements to be placed within the Div.
    init(@TagBuilder content: () -> [any Tag]) {
        self.content = content()
    }
    
    /// The elements that make up the content of the Div.
    @TagBuilder var contentBody: [any Tag] {
        path
        content
    }
    
    /// The entire body of the Div element, including its content and background.
    var body: [any Tag] {
        contentBody
    }
}

extension Div {
    /// Scales the entire Div element, including its background and content, by a specified factor.
    /// - Parameter factor: The scaling factor. A value of 1.0 maintains the original size, values greater than 1.0 increase the size, and values less than 1.0 decrease the size.
    /// - Returns: A new Div element with the applied scaling.
    func scaled(factor: Double) -> Div {
        var div = self
        div.path = div.path.scaled(factor: factor)
        div.content = div.content.scaled(factor: factor)
        return div
    }
    
    /// Sets the origin (x, y) coordinates of the Div element within its parent container.
    /// - Parameter value: A tuple containing the x and y coordinates of the origin.
    /// - Returns: A new Div element with the updated origin coordinates.
    func parentCoordinates(_ value: (Double, Double)) -> Div {
        var div = self
        div.path = div.path.parentCoordinates(value)
        return div
    }
    
    /// Sets the dimensions of the parent container used for some internal calculations within the Div element.
    /// - Parameter value: The dimension (width and height) of the parent container.
    /// - Returns: A new Div element with the specified parent dimension set.
    func parentDimension(_ value: Dimension) -> Div {
        var div = self
        div.path = div.path.parentDimension(value)
        div.content = div.content.parentDimension(value)
        return div
    }
    
    /// Aligns the content elements within the Div horizontally to the center.
    /// - Returns: A new Div element with its content centered horizontally.
    func alignItemsCenter() -> Div {
        var div = self
        div.content = div.content.center()
        return div
    }
    
    /// Centers the entire Div element within its parent container.
    /// - Returns: A new Div element centered within its parent.
    func center() -> Div {
        var div = self
        div.path = div.path.center()
        div.content = content.parentCoordinates((div.path.data.frame.0.0, div.path.data.frame.0.1))
        return div
    }
    
    /// Sets the position of the Div element within its parent container.
    /// - Parameters:
    ///   - x: The x coordinate of the top-left corner.
    ///   - y: The y coordinate of the top-left corner.
    /// - Returns: A new Div element with the specified position.
    func position(x: Double, y: Double) -> Div {
        var div = self
        let saveWidth = div.rectPathData.width
        let saveHeight = div.rectPathData.height
        div.rectPathData = RectPathData(x: x, y: y, width: saveWidth, height: saveHeight)
        div.content = content.parentCoordinates((x, y))
        return div
    }

    /// Rounds the northeast corner of the Div to create a rounded rectangle.
    /// - Parameter rx: The radius value for the northeast corner.
    /// - Returns: A new Div element with the specified northeast corner radius.
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

    /// Rounds the southeast corner of the Div to create a rounded rectangle.
    /// - Parameter rx: The radius value for the southeast corner.
    /// - Returns: A new Div element with the specified southeast corner radius.
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

    /// Rounds the southwest corner of the Div to create a rounded rectangle.
    /// - Parameter rx: The radius value for the southwest corner.
    /// - Returns: A new Div element with the specified southwest corner radius.
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

    /// Rounds the northwest corner of the Div to create a rounded rectangle.
    /// - Parameter rx: The radius value for the northwest corner.
    /// - Returns: A new Div element with the specified northwest corner radius.
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
    
    /// Changes the width and height of the Div element.
    /// - Parameters:
    ///   - width: The new width value.
    ///   - height: The new height value.
    /// - Returns: A new Div element with the specified dimensions.
    func dimension(width: Double, height: Double) -> Div {
        var div = self
        let saveX = div.rectPathData.x
        let saveY = div.rectPathData.y
        div.rectPathData = RectPathData(x: saveX, y: saveY, width: width, height: height)
        div.content = content.parentCoordinates((saveX, saveY))
        return div
    }
    
    
    /// Changes the width and height of the Div element. This method is preserved as a legacy.
    /// - Parameters:
    ///   - width: The new width value.
    ///   - height: The new height value.
    /// - Returns: A new Div element with the specified dimensions.
    func dimensionAlt(width: Double, height: Double) -> Div {
        var div = self
        let dimension = Dimension(width: width, height: height)
        div.rectPathData = div.rectPathData.dimension(width: width, height: width)
        div.content = content.parentDimension(dimension)
        div.path = div.path.parentDimension(dimension)
        return div
    }
    
    /// Changes the width of the border (stroke) around the Div element.
    /// - Parameter width: The new width of the stroke (border).
    /// - Returns: A new Div element with the specified stroke width.
    func stroke(width: Double) -> Div {
        var div = self
        div.path = div.path.stroke(width: width)
        return div
    }
    
    /// Changes the color of the border (stroke) around the Div element.
    /// - Parameter color: A valid hex color string representing the new stroke color.
    /// - Returns: A new Div element with the specified stroke color.
    func stroke(color: String) -> Div {
        var div = self
        div.path = div.path.stroke(color: color)
        return div
    }
    
    /// Fills the background of the Div element with a specified color.
    /// - Parameter color: A valid hex color string representing the fill color.
    /// - Returns: A new Div element with the specified background color.
    func fill(color: String) -> Div {
        var div = self
        div.path = div.path.fill(color: color)
        return div
    }
}
