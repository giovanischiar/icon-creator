//
//  Movable.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

/// A protocol for elements that can be moved.
protocol Movable {
    
    /// Modifies the element's position to move it.
    /// - Parameters:
    ///   - x: The x coordinate of the new position.
    ///   - y: The y coordinate of the new position.
    mutating func move(x: Double, y: Double)
}
