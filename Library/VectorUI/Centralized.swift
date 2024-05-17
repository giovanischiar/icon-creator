//
//  Centralized.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

/// A protocol for elements that can be positioned in the center of their parent container.
protocol Centralized {
    /// The type used to turn the struct used into his own struct type again
    associatedtype T
    
    /// Modifies the element's position to be centered within its parent container.
    /// - Returns: The element itself with its position adjusted to be centered.
    func center() -> T
    
    /// Sets the dimension of the parent container used for centering calculations.
    /// - Parameter dimension: The dimension (e.g., width or height) of the parent container.
    /// - Returns: The element with the specified parent dimension set.
    func parentDimension(_ value: Dimension) -> T
}
