//
//  Main.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

import Foundation

class Main {
    public static func main(args: [String]) async {
        await IconCreator(args: args).run()
    }
}

await Main.main(args: CommandLine.arguments)
