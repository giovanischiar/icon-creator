//
//  Scalable.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

/// A protocol for elements that can be scaled.
protocol Scalable {
    /// Scales the element by a specified factor.
    ///
    /// This method modifies the element's internal state to achieve scaling. The specific behavior
    /// for handling negative factors or factors exceeding 1.0 might vary depending on the
    /// implementing element.
    ///
    /// - Parameter factor: A Double value representing the scaling factor.
    ///   - A value of 1.0 maintains the current size.
    ///   - Values greater than 1.0 scale the element up.
    ///   - Values less than 1.0 scale the element down.
    mutating func scale(factor: Double)
}
