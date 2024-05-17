//
//  FileCreator.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

import Foundation

/// A struct responsible for creating files.
struct FileCreator {
    /// The content to be written to the file.
	let content: String
    
    /// The directory path where the file will be created.
	let directory: String

    /// The name of the file (without extension).
	let name: String
    
    /// The file extension (e.g., "txt", "svg").
	let ext: String

    /// The full path of the file, including directory, name, and extension.
	var filePath: String { "\(directory)/\(name).\(ext)" }

    /// Creates the file on disk.
	func create() {
    	FileManager.default.createFile (
   			atPath: filePath, 
    		contents: Data(content.utf8), 
    			attributes: nil
    	) ? print("\(filePath) created successfully") : print("\(filePath) failed")
	}
}
