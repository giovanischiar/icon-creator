//
//  IconExtensions.swift
//
//
//  Created by Giovani Schiar on 16/12/22.
//

extension IconBackground {
    /// Accesses the vector drawable representation of the icon background.
    var vectordrawable: String {
        return self.background.vectordrawable
    }
}

extension IconForeground {
    /// Accesses the vector drawable representation of the icon foreground.
    var vectordrawable: String {
        return TagDecoder().prettyDecode(self, xmlType: .vectordrawable)
    }
}

extension IconBackground {
    /// Retrieves the content body of the background, containing its elements.
    var contentBody: [any Tag] {
        return background.contentBody
    }
    
    /// Creates a squircle-shaped version of the background with a specified radius.
    /// - Parameter radius: The radius of the squircle, calculated as 10% of the size.
    /// - Returns: A new Background object with the squircle shape.
    func squircle() -> Background {
        return self.background.radius(10 %% size)
    }
    
    /// Creates a circle-shaped version of the background.
    /// - Returns: A new Background object with the circle shape.
    func circle() -> Background {
        return self.background.radius(size/2)
    }
}

extension IconForeground {
    /// Retrieves the content body of the foreground, containing its elements.
    var contentBody: [any Tag] {
        return foreground.contentBody
    }
    
    /// Scales the foreground of the icon by a specified factor.
    /// - Parameter factor: The scaling factor applied to the foreground.
    /// - Returns: A new Foreground object with the applied scaling.
    func scaled(factor: Double) -> Foreground {
        var foreground = self
        foreground.scaleFactor = factor
        return foreground.foreground.scaled(factor: factor)
    }
    
    /// Centers the foreground of the icon within its parent container.
    /// - Returns: A new Foreground object with the centered position.
    func center() -> Foreground {
        return foreground.center()
    }
    
    /// Sets the parent dimension for the foreground element.
    /// - Parameter value: The dimension value for the parent container.
    /// - Returns: A new Foreground object with the updated parent dimension.
    func parentDimension(_ value: Dimension) -> Foreground {
        return foreground.parentDimension(value)
    }
}

extension Background {
    /// Accesses the vector drawable representation of the icon background.
    var vectordrawable: String {
        return TagDecoder().prettyDecode(self, xmlType: .vectordrawable)
    }
}

extension Foreground {
    /// Accesses the vector drawable representation of the icon foreground.
    var vectordrawable: String {
        return TagDecoder().prettyDecode(self, xmlType: .vectordrawable)
    }
}



