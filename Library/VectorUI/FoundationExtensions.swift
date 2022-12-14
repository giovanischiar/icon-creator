//
//  FoundationExtensions.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

import Foundation

infix operator %%

extension [Double] {
    var stringArray: [String] { self.isEmpty ? [] : self.map { String(format: "%g", $0) } }
}

extension String {
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
    static func %%(lhs: Double, rhs: Double) -> Double {
        return rhs * lhs/100.0
    }
}
