//
//  Moved.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

/// A protocol for elements that can be moved.
protocol Moved {
    /// The type used to turn the struct used into his own struct type again
    associatedtype T
    
    
    /// Modifies the element's position to move it.
    /// - Parameters:
    ///   - x: The x coordinate of the new position.
    ///   - y: The y coordinate of the new position.
    /// - Returns: The element itself with its position adjusted.
    func moved(x: Double, y : Double) -> T
}
