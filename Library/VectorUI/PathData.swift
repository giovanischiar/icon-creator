//
//  PathData.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

/// The struct that encapsulates the `d` attribute of an SVG path.
struct PathData: PathDatable {
    /// The list of path commands that define the path geometry.
    var commands: [PathDataCommand]
    
    /// Initializes the `PathData` struct with an array of `PathDataCommand` objects.
    /// - Parameter commands: An array of `PathDataCommand` objects representing the path data.
    init(commands: [PathDataCommand]) { self.commands = commands }
    
    /// Initializes the `PathData` struct by parsing a string containing SVG path data.
    /// - Parameter commands: A string representing the SVG path data.
    init(commands: String) { self.commands = commands.commands}
}
