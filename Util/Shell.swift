//
//  Shell.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

import Foundation

/// Executes a shell command and prints the output to the console.
///
/// - Parameter command: The shell command to execute as a string.
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
