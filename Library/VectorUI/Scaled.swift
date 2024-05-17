//
//  Scaled.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

/// A protocol for elements that are scaled.
protocol Scaled {
    /// The type representing the scaled version of the conforming element.
    associatedtype T
    
    /// Scales the element and returns a new instance with the applied scaling.
    ///
    /// This method creates a new instance of the conforming type (`ScaledType`) with its internal state
    /// adjusted to reflect the scaling factor. The specific behavior for handling negative factors
    /// or factors exceeding 1.0 might vary depending on the implementing element.
    ///
    /// - Parameter factor: A Double value representing the scaling factor.
    ///   - A value of 1.0 maintains the current size.
    ///   - Values greater than 1.0 scale the element up.
    ///   - Values less than 1.0 scale the element down.
    /// - Returns: A new instance of the conforming type with the applied scaling.
    func scaled(factor: Double) -> T
}
