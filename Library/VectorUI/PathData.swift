//
//  PathData.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

struct PathData: PathDatable {
    var commands: [PathDataCommand]
    init(commands: [PathDataCommand]) { self.commands = commands }
    init(commands: String) { self.commands = commands.commands}
}
