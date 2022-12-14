//
//  Shell.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

func shell(_ command: String) {
    print(command)
    let task = Process()
    let pipe = Pipe()

    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-c", command]
    task.launchPath = "/bin/zsh"
    task.standardInput = nil
    task.launch()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!
    if (!output.isEmpty) { print(output) }
}
