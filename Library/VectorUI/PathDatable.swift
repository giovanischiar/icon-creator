//
//  PathDatable.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

import Foundation

protocol PathDatable: CustomStringConvertible, Scalable, Movable {
    var commands: [PathDataCommand] { get set }
    var width: Double { get }
    var height: Double { get }
}

extension PathDatable {
    var frame: ((Double, Double), (Double, Double)) {
        let xS = commands.coordinates.map(\.0)
        let yS = commands.coordinates.map(\.1)
        return ((xS.min() ?? 0, yS.min() ?? 0), (xS.max() ?? 0, yS.max() ?? 0))
    }
    
    var width: Double {
        let minX = frame.0.0
        let maxX = frame.1.0
        return maxX - minX
    }
    var height: Double {
        let minY = frame.0.1
        let maxY = frame.1.1
        return maxY - minY
    }
}

extension PathDatable {
    var description: String { "\(commands.map(\.description).joined(separator: " "))" }
}

extension PathDatable {
    mutating func scale(factor: Double) {
        let save = (frame.0.0, frame.0.1)
        commands.move(x: -frame.0.0, y: -frame.0.1)
        commands.scale(factor: factor)
        commands.move(x: save.0, y: save.1)
    }
    
    mutating func move(x: Double, y: Double) {
        commands.move(x: x, y: y)
    }
    
    mutating func centralize(parentDimension: Dimension) {
        let x = parentDimension.width/2.0 - width/2.0
        let y = parentDimension.height/2.0 - height/2.0
        commands.move(x: x, y: y)
    }
}
