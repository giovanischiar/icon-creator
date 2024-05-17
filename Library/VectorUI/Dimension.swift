//
//  Dimension.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//


/// Represents the dimensions (width and height) of a rectangular component.
struct Dimension {
    /// The width of the rectangle.
    let width: Double
    /// The height of the rectangle.
    let height: Double
}

extension Dimension {
    /// The center point of the rectangle calculated from its width and height.
    var center: (Double, Double) { (width/2, height/2) }
}

extension Dimension {
    /// Multiplies a dimension by a scalar value.
    /// - Parameters:
    ///   - lhs: The dimension to be multiplied.
    ///   - rhs: The scalar value.
    /// - Returns: A new dimension with the width and height multiplied by the scalar.
    static func *(lhs: Dimension, rhs: Double) -> Dimension {
        return Dimension(width: lhs.width * rhs, height: lhs.height * rhs)
    }
    
    /// Compares two dimensions for equality.
    /// - Parameters:
    ///   - lhs: The first dimension.
    ///   - rhs: The second dimension.
    /// - Returns: True if both width and height are equal, false otherwise.
    static func ==(lhs: Dimension, rhs: Dimension) -> Bool {
        return lhs.width == rhs.width && lhs.height == rhs.height
    }
}
