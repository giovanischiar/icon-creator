//
//  Centralizable.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

/// A protocol for elements that can be positioned in the center of their parent container.
protocol Centralizable {
    /// Modifies the element's position to be centered within its parent container.
     /// - Parameter parentDimension: The dimension (e.g., width or height) of the parent container.
    mutating func centralize(parentDimension: Dimension)
}
