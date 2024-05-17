//
//  LinePathData.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

/// A PathDatable implementation representing a line segment.
struct LinePathData: PathDatable {
    /// The commands array containing path commands for the line segment.
    var commands: [PathDataCommand]
    
    /// Initializes a `LinePathData` object representing a line segment from (x1, y1) to (x2, y2).
    /// - Parameters:
    ///   - x1: The x-coordinate of the starting point.
    ///   - y1: The y-coordinate of the starting point.
    ///   - x2: The x-coordinate of the ending point.
    ///   - y2: The y-coordinate of the ending point.
    init(x1: Double, y1: Double, x2: Double, y2: Double) {
        commands = "M \(x1) \(y1) L \(x2) \(y2)".commands
    }
    
    /// Initializes a `LinePathData` object by setting the command array.
    /// - Parameter commands: The command array defining the line path.
    init(commands: [PathDataCommand]) {
        self.commands = commands
    }
    
    /// Concatenates two LinePathData objects, creating a new line path with potentially disconnected segments.
    /// - Parameters:
    ///   - lhs: The left operand (LinePathData object).
    ///   - rhs: The right operand (LinePathData object).
    /// - Returns: A new LinePathData object with combined commands from both operands.
    static func +(lhs: LinePathData, rhs: LinePathData) -> LinePathData {
        return LinePathData(commands: lhs.commands + rhs.commands)
    }
}

extension LinePathData: Scaled, Moved {
    /// Scales the line segment represented by this LinePathData object by a specified factor.
    /// - Parameter factor: The scaling factor. A value of 1.0 maintains the original size, values greater than 1.0 increase the size, and values less than 1.0 decrease the size.
    /// - Returns: *This* LinePathData object after being scaled.
    func scaled(factor: Double) -> LinePathData {
        var linePathData = self
        linePathData.scale(factor: factor)
        return linePathData
    }
    
    /// Moves the line segment represented by this LinePathData object by the specified coordinates.
    /// - Parameters:
    ///   - x: The amount to move horizontally.
    ///   - y: The amount to move vertically.
    /// - Returns: *This* LinePathData object after being moved.
    func moved(x: Double, y: Double) -> LinePathData {
        var linePathData = self
        linePathData.move(x: x, y: y)
        return linePathData
    }
}
