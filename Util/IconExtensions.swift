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

extension Background {
    var vectordrawable: String {
        return TagDecoder().prettyDecode(self, xmlType: .vectordrawable)
    }
}
