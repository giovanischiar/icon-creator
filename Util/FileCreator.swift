//
//  FileCreator.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

struct FileCreator {
	let content: String
	let directory: String
	let name: String
	let ext: String

	var filePath: String { "\(directory)/\(name).\(ext)" }

	func create() -> Bool {
    	return FileManager.default.createFile (
   			atPath: filePath, 
    		contents: Data(content.utf8), 
    			attributes: nil
    	)
	}
}
