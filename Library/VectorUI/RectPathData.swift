//
//  RectPathData.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

struct RectPathData: PathDatable {
    var commands: [PathDataCommand]
    var width: Double
    var height: Double
    
    init (x: Double = 0, y: Double = 0, width: Double, height: Double, rx: Double = 0) {
        self.width = width
        self.height = height
        let archNortheast = rx != 0 ? " a \(rx) \(rx) 0 0 1 \(rx) \(rx)" : ""
        let archSoutheast = rx != 0 ? " a \(rx) \(rx) 0 0 1 -\(rx) \(rx)" : ""
        let archSouthwest = rx != 0 ? " a \(rx) \(rx) 0 0 1 -\(rx) -\(rx)" : ""
        let archNorthwest = rx != 0 ? " a \(rx) \(rx) 0 0 1 \(rx) -\(rx)" : ""
        
        commands = "M \(x + rx) \(y) h \(width - rx * 2)\(archNortheast) v \(height - rx * 2)\(archSoutheast) h -\(width - rx * 2)\(archSouthwest) v -\(height - rx * 2)\(archNorthwest) Z".commands
    }
    
    mutating func scale(factor: Double) {
        let save = (frame.0.0, frame.0.1)
        commands.move(x: -frame.0.0, y: -frame.0.1)
        commands.scale(factor: factor)
        width *= factor
        height *= factor
        commands.move(x: save.0, y: save.1)
    }
}

