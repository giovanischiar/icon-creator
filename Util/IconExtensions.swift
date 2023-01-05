//
//  IconExtensions.swift
//
//
//  Created by Giovani Schiar on 16/12/22.
//

extension IconBackground {
    var vectordrawable: String {
        return self.background.vectordrawable
    }
}

extension IconForeground {
    var vectordrawable: String {
        return TagDecoder().prettyDecode(self, xmlType: .vectordrawable)
    }
}

extension IconBackground {
    var contentBody: [any Tag] {
        return background.contentBody
    }
    
    func squircle() -> Background {
        return self.background.radius(10 %% size)
    }
    
    func circle() -> Background {
        return self.background.radius(size/2)
    }
}

extension IconForeground {
    var contentBody: [any Tag] {
        return foreground.contentBody
    }
    
    func scaled(factor: Double) -> Foreground {
        var foreground = self
        foreground.scaleFactor = factor
        return foreground.foreground.scaled(factor: factor)
    }
    
    func center() -> Foreground {
        return foreground.center()
    }
    
    func parentDimension(_ value: Dimension) -> Foreground {
        return foreground.parentDimension(value)
    }
}

extension Background {
    var vectordrawable: String {
        return TagDecoder().prettyDecode(self, xmlType: .vectordrawable)
    }
}

extension Foreground {
    var vectordrawable: String {
        return TagDecoder().prettyDecode(self, xmlType: .vectordrawable)
    }
}



