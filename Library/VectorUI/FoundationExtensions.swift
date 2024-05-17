//
//  FoundationExtensions.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

import Foundation

infix operator %%

extension [Double] {
    /// Converts an array of Double values to an array of String representations.
    /// - Returns: A new array of Strings containing string representations of the original Double values.
    var stringArray: [String] { self.isEmpty ? [] : self.map { String(format: "%g", $0) } }
}

extension String {
    /// Extracts an array of `PathDataCommand` objects from a string representing an SVG path data attribute (typically the 'd' value).
    /// - Returns: An array of `PathDataCommand` objects representing the parsed path commands and their parameters.
    var commands: [PathDataCommand] {
        do {
            let regex = try NSRegularExpression(pattern: #"([A-Z]|[a-z])((\s-?[0-9]+\.?[0-9]*)*)"#)
            let matchesRanges = regex.matches(in: self, range: NSRange(0..<self.count))
            let matches = matchesRanges.map { String(self[Range($0.range, in: self)!]) }
            let commands = matches.map { match in
                let values = match.split(separator: " ").map { String($0) }
                let command = Character(values[0])
                let parameters = values.dropFirst().map { return Double($0) ?? 0.0 }
                return PathDataCommand(command: command, parameters: parameters)
            }
            return commands
        } catch { return [] }
    }
}

extension Double {
    /// Normalizes a Double value between -1 and 1 by multiplying it by a percentage factor (rhs).
    /// - Parameters:
    ///   - lhs: The value to normalize.
    ///   - rhs: The percentage factor (between -1 and 1).
    /// - Returns: The normalized value between -1 and 1.
    static func %%(lhs: Double, rhs: Double) -> Double {
        return rhs * lhs/100.0
    }
}
