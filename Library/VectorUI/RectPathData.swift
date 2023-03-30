//
//  RectPathData.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

struct RectPathData: PathDatable {
    var commands: [PathDataCommand]
    var x: Double
    var y: Double
    var width: Double
    var height: Double
    var nerx: Double
    var serx: Double
    var swrx: Double
    var nwrx: Double
    
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

    init (x: Double = 0, y: Double = 0, width: Double, height: Double, rx: Double = 0) {
        self.init(x: x, y: y, width: width, height: height, nerx: rx, serx: rx, swrx: rx, nwrx: rx)
    }

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
    
    mutating func scale(factor: Double) {
        let save = (frame.0.0, frame.0.1)
        commands.move(x: -frame.0.0, y: -frame.0.1)
        commands.scale(factor: factor)
        width *= factor
        height *= factor
        commands.move(x: save.0, y: save.1)
    }
    
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
    func dimension(width: Double, height: Double) -> RectPathData {
        var pathData = self
        pathData.width = width
        pathData.height = height
        return RectPathData(pathData)
    }
}
