//
//  IconExtensions.swift
//
//
//  Created by Giovani Schiar on 16/12/22.
//

extension IconBackground {
    var vectordrawable: String {
        return TagDecoder().prettyDecode(self.background, xmlType: .vectordrawable)
    }
}

extension IconForeground {
    var vectordrawable: String {
        return TagDecoder().prettyDecode(self, xmlType: .vectordrawable)
    }
}
