//
//  PathDataCommand.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

struct PathDataCommand {
    let command: Character
    var parameters: [Double]
}

extension PathDataCommand {
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
    var description: String {
        return parameters.isEmpty ? "\(command)" : "\(command) \(parameters.stringArray.joined(separator: " "))"
    }
}

extension [PathDataCommand]: Scalable, Movable {
    mutating func scale(factor: Double) {
        var i = 0
        while (i < count) {
            var pathDataCommand = self[i]
            pathDataCommand.scale(factor: factor)
            self[i] = pathDataCommand
            i += 1
        }
    }
    
    mutating func move(x: Double, y: Double) {
        var i = 0
        while (i < count) {
            var pathDataCommand = self[i]
            pathDataCommand.move(x: x, y: y)
            self[i] = pathDataCommand
            i += 1
        }
    }
    
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
    var coordinates: [(Double, Double)] {
        map { $0.coordinates }.reduce([], +)
    }
}
