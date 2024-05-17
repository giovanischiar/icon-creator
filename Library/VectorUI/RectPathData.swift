//
//  RectPathData.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

/// The path data representing a rectangular path, potentially with rounded corners.
struct RectPathData: PathDatable {
    /// The list of path commands that define the rectangle geometry
    var commands: [PathDataCommand]
    
    /// The x coordinate of the top-left corner.
    var x: Double
    
    /// The y coordinate of the top-left corner.
    var y: Double
    
    /// The width of the rectangle.
    var width: Double
    
    /// The height of the rectangle.
    var height: Double
    
    /// The radius for the northeast corner.
    var nerx: Double
    
    /// The radius for the southeast corner.
    var serx: Double
    
    /// The radius for the southwest corner.
    var swrx: Double
    
    /// The radius for the northwest corner.
    var nwrx: Double
    
    /// Initialize the object with other RectPathData.
    /// - Parameter value: The RectPathData object to copy from.
    init (_ value: RectPathData) { 
        self.init(
            x: value.x, 
            y: value.y, 
            width: value.width, 
            height: value.height, 
            nerx: value.nerx,
            serx: value.serx,
            swrx: value.swrx,
            nwrx: value.nwrx
        )
    }
    
    /// Initialize the object setting round borders for all corners.
    /// - Parameters:
    ///   - x: The x coordinate.
    ///   - y: The y coordinate.
    ///   - width: The width.
    ///   - height: The height.
    ///   - rx: The radius for each corner (optional, defaults to 0).
    init (x: Double = 0, y: Double = 0, width: Double, height: Double, rx: Double = 0) {
        self.init(x: x, y: y, width: width, height: height, nerx: rx, serx: rx, swrx: rx, nwrx: rx)
    }

    
    /// Initialize the object setting round borders for each corners.
    /// - Parameters:
    ///   - x: The x coordinate.
    ///   - y: The y coordinate.
    ///   - width: The width.
    ///   - height: The height.
    ///   - nerx: The radius for the northeast corner (optional, defaults to 0).
    ///   - serx: The radius for the  southeast corner (optional, defaults to 0).
    ///   - swrx: The radius for the southwest corner (optional, defaults to 0).
    ///   - nwrx: The radius for the northwest  corner (optional, defaults to 0).
    init (x: Double = 0, y: Double = 0, width: Double, height: Double, nerx: Double, serx: Double, swrx: Double, nwrx: Double) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.nerx = nerx
        self.serx = serx
        self.swrx = swrx
        self.nwrx = nwrx
        let archNortheast = nerx != 0 ? " a \(nerx) \(nerx) 0 0 1 \(nerx) \(nerx)" : ""
        let archSoutheast = serx != 0 ? " a \(serx) \(serx) 0 0 1 -\(serx) \(serx)" : ""
        let archSouthwest = swrx != 0 ? " a \(swrx) \(swrx) 0 0 1 -\(swrx) -\(swrx)" : ""
        let archNorthwest = nwrx != 0 ? " a \(nwrx) \(nwrx) 0 0 1 \(nwrx) -\(nwrx)" : ""
        
        commands = "M \(x + nwrx) \(y) h \(width - (nwrx + nerx))\(archNortheast) v \(height - (nerx + serx))\(archSoutheast) h -\(width - (serx + swrx))\(archSouthwest) v -\(height - (swrx + nwrx))\(archNorthwest) Z".commands
    }
    
    /// Scales the path data of the RectPathData object by a specified factor.
    /// - Parameter factor: A Double value representing the scaling factor.
    ///   - A value of 1.0 maintains the current size.
    ///   - Values greater than 1.0 scale the path up.
    ///   - Values less than 1.0 scale the path down.
    mutating func scale(factor: Double) {
        let save = (frame.0.0, frame.0.1)
        commands.move(x: -frame.0.0, y: -frame.0.1)
        commands.scale(factor: factor)
        width *= factor
        height *= factor
        commands.move(x: save.0, y: save.1)
    }
    
    /// Define the radius for all borders.
    /// - Parameter value: The radius value.
    /// - Returns: A new RectPathData with all the corners rounded according to the radius value.
    func radius(_ value: Double) -> RectPathData {
        var pathData = self
        pathData.nerx = value
        pathData.serx = value
        pathData.swrx = value
        pathData.nwrx = value
        return RectPathData(pathData)
    }
}

extension RectPathData {
    /// Define the dimensions of the RectPathData.
    /// - Parameters:
    ///   - width: The width.
    ///   - height: The height.
    /// - Returns: A new RectPathData with the dimensions changed.
    func dimension(width: Double, height: Double) -> RectPathData {
        var pathData = self
        pathData.width = width
        pathData.height = height
        return RectPathData(pathData)
    }
}
