//
//  Info.swift
//
//
//  Created by Giovani Schiar on 14/12/22.
//

/// Represents general information from the Contents.json file of an Xcode asset catalog.
struct Info: Codable {
    /// The name of the author of the asset catalog.
    let author: String
    
    /// The version number of the Contents.json file.
    let version: Int
}
