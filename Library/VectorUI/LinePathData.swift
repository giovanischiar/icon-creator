//
//  LinePathData.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

struct LinePathData: PathDatable {
    var commands: [PathDataCommand]
    
    init(x1: Double, y1: Double, x2: Double, y2: Double) {
        commands = "M \(x1) \(y1) L \(x2) \(y2)".commands
    }
    
    init(commands: [PathDataCommand]) {
        self.commands = commands
    }
    
    static func +(lhs: LinePathData, rhs: LinePathData) -> LinePathData {
        return LinePathData(commands: lhs.commands + rhs.commands)
    }
}

extension LinePathData: Scaled, Moved {
    func scaled(factor: Double) -> LinePathData {
        var linePathData = self
        linePathData.scale(factor: factor)
        return linePathData
    }
    
    func moved(x: Double, y: Double) -> LinePathData {
        var linePathData = self
        linePathData.move(x: x, y: y)
        return linePathData
    }
}
