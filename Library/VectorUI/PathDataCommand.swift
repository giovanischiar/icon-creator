//
//  PathDataCommand.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

/// The representation of a single command within the `d` attribute of an SVG path.
struct PathDataCommand {
    /// The character representing the SVG path command type (e.g., "M", "L", "C").
    let command: Character
    /// The list of parameters associated with the command. The number and meaning of parameters vary depending on the specific command type.
    var parameters: [Double]
}

extension PathDataCommand {
    /// The coordinates extracted from the parameters array based on the command type.
    var coordinates: [(Double, Double)] {
        switch(command) {
            case "a"..."z":
                return []
            case "A":
                let count = parameters.count
                if (count < 7) { return [] }
                let lastIndex = count - 1
                return [(parameters[lastIndex-1], parameters[lastIndex])]
            default:
                var output: [(Double, Double)] = []
                var i = 0
                while(i < (parameters.count - 1)) {
                    output.append((parameters[i], parameters[i+1]))
                    i+=2
                }
                return output
        }
        
    }
}

extension PathDataCommand: Scalable, Movable {
    /// Scales the command params of the PathDataCommand object by a specified factor.
    /// - Parameter factor: A Double value representing the scaling factor.
    ///   - A value of 1.0 maintains the current size.
    ///   - Values greater than 1.0 scale the path up.
    ///   - Values less than 1.0 scale the path down.
    mutating func scale(factor: Double) {
        switch (command) {
            case "A", "a":
                let count = parameters.count
                if (count < 7) { return }
                let lastIndex = count - 1
                parameters[lastIndex-1] = parameters[lastIndex-1] * factor
                parameters[lastIndex] = parameters[lastIndex] * factor
            default:
                parameters = parameters.map {$0 * factor}
        }
    }
    
    /// Moves the command params of the PathDataCommand object by a specified offset.
    /// - Parameters:
    ///   - x: A Double value representing the offset in the x-direction.
    ///     - Positive values move the path to the right.
    ///     - Negative values move it to the left.
    ///   - y: A Double value representing the offset in the y-direction.
    ///     - Positive values move the path down.
    ///     - Negative values move it up.
    /// - Returns: A new Path object with the moved path data.
    mutating func move(x: Double, y: Double) {
        switch (command) {
            case "a"..."z":
                break
            case "A":
                let count = parameters.count
                if (count < 7) { return }
                let lastIndex = count - 1
                parameters[lastIndex-1] = parameters[lastIndex-1] + x
                parameters[lastIndex] = parameters[lastIndex] + y
            default:
                parameters = parameters.enumerated().map { (index, value) in index % 2 == 0 ? value + x : value + y }
        }
    }
    
    /// Translates the command params of the PathDataCommand object by a specified offset.
    /// - Parameters:
    ///   - x: A Double value representing the offset in the x-direction.
    ///     - Positive values move the path to the right.
    ///     - Negative values move it to the left.
    ///   - y: A Double value representing the offset in the y-direction.
    ///     - Positive values move the path down.
    ///     - Negative values move it up.
    /// - Returns: A new Path object with the moved path data.
    mutating func translate(x: Double, y: Double) {
        switch (command) {
            case "a"..."z":
                break
            case "A":
                let count = parameters.count
                if (count < 7) { return }
                let lastIndex = count - 1
                parameters[lastIndex-1] = x
                parameters[lastIndex] = y
            default:
                parameters = parameters.enumerated().map { (index, value) in index % 2 == 0 ? x : y }
        }
    }
}

extension PathDataCommand: CustomStringConvertible {
    /// The string representation of the command, including the command letter and its parameters.
    var description: String {
        return parameters.isEmpty ? "\(command)" : "\(command) \(parameters.stringArray.joined(separator: " "))"
    }
}

extension [PathDataCommand]: Scalable, Movable {
    /// Scales the path data of the PathDataCommand object by a specified factor.
    /// - Parameter factor: A Double value representing the scaling factor.
    ///   - A value of 1.0 maintains the current size.
    ///   - Values greater than 1.0 scale the path up.
    ///   - Values less than 1.0 scale the path down.
    mutating func scale(factor: Double) {
        var i = 0
        while (i < count) {
            var pathDataCommand = self[i]
            pathDataCommand.scale(factor: factor)
            self[i] = pathDataCommand
            i += 1
        }
    }
    
    /// Moves the path data of the PathDataCommand object by a specified offset.
    /// - Parameters:
    ///   - x: A Double value representing the offset in the x-direction.
    ///     - Positive values move the path to the right.
    ///     - Negative values move it to the left.
    ///   - y: A Double value representing the offset in the y-direction.
    ///     - Positive values move the path down.
    ///     - Negative values move it up.
    /// - Returns: A new Path object with the moved path data.
    mutating func move(x: Double, y: Double) {
        var i = 0
        while (i < count) {
            var pathDataCommand = self[i]
            pathDataCommand.move(x: x, y: y)
            self[i] = pathDataCommand
            i += 1
        }
    }
    
    /// Translates the command params of the PathDataCommand object by a specified offset.
    /// - Parameters:
    ///   - x: A Double value representing the offset in the x-direction.
    ///     - Positive values move the path to the right.
    ///     - Negative values move it to the left.
    ///   - y: A Double value representing the offset in the y-direction.
    ///     - Positive values move the path down.
    ///     - Negative values move it up.
    /// - Returns: A new Path object with the moved path data.
    mutating func translate(x: Double, y: Double) {
        var i = 0
        while (i < count) {
            var pathDataCommand = self[i]
            pathDataCommand.translate(x: x, y: y)
            self[i] = pathDataCommand
            i += 1
        }
    }
}

extension [PathDataCommand] {
    /// An array containing all the coordinates extracted from the PathDataCommand objects in the array.
    var coordinates: [(Double, Double)] {
        map { $0.coordinates }.reduce([], +)
    }
}
