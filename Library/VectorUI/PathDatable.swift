//
//  PathDatable.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

import Foundation

/// Protocol that defines a common interface for objects representing custom path data.
protocol PathDatable: CustomStringConvertible, Scalable, Movable {
    /// The list of path commands that define the path geometry.
    var commands: [PathDataCommand] { get set }
    
    /// The width of the path data.
    var width: Double { get }
    
    /// The height of the path data.
    var height: Double { get }
}

extension PathDatable {
    /// The bounding box of the path data, calculated as the top-left and bottom-right corners.
    var frame: ((Double, Double), (Double, Double)) {
        let xS = commands.coordinates.map(\.0)
        let yS = commands.coordinates.map(\.1)
        return ((xS.min() ?? 0, yS.min() ?? 0), (xS.max() ?? 0, yS.max() ?? 0))
    }
    
    /// The width of the path data, calculated as the difference between the maximum and minimum X coordinates.
    var width: Double {
        let minX = frame.0.0
        let maxX = frame.1.0
        return maxX - minX
    }
    
    /// The height of the path data, calculated as the difference between the maximum and minimum Y coordinates.
    var height: Double {
        let minY = frame.0.1
        let maxY = frame.1.1
        return maxY - minY
    }
}

extension PathDatable {
    /// The string representation of the commands.
    var description: String { "\(commands.map(\.description).joined(separator: " "))" }
}

extension PathDatable {
    /// Scales the path data of the Path object by a specified factor.
    /// - Parameter factor: A Double value representing the scaling factor.
    ///   - A value of 1.0 maintains the current size.
    ///   - Values greater than 1.0 scale the path up.
    ///   - Values less than 1.0 scale the path down.
    mutating func scale(factor: Double) {
        let save = (frame.0.0, frame.0.1)
        commands.move(x: -frame.0.0, y: -frame.0.1)
        commands.scale(factor: factor)
        commands.move(x: save.0, y: save.1)
    }
    
    /// Moves the path data of the Path object by a specified offset.
    /// - Parameters:
    ///   - x: A Double value representing the offset in the x-direction.
    ///     - Positive values move the path to the right.
    ///     - Negative values move it to the left.
    ///   - y: A Double value representing the offset in the y-direction.
    ///     - Positive values move the path down.
    ///     - Negative values move it up.
    /// - Returns: A new Path object with the moved path data.
    mutating func move(x: Double, y: Double) {
        commands.move(x: x, y: y)
    }
    
    /// Centralize the path inside parent.
    /// - Parameter parentDimension: The parent dimension.
    mutating func centralize(parentDimension: Dimension) {
        let x = parentDimension.width/2.0 - width/2.0
        let y = parentDimension.height/2.0 - height/2.0
        commands.move(x: x, y: y)
    }
}
