//
//  Dimension.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

struct Dimension {
    let width: Double
    let height: Double
}

extension Dimension {
    var center: (Double, Double) { (width/2, height/2) }
}

extension Dimension {
    static func *(lhs: Dimension, rhs: Double) -> Dimension {
        return Dimension(width: lhs.width * rhs, height: lhs.height * rhs)
    }
    
    static func ==(lhs: Dimension, rhs: Dimension) -> Bool {
        return lhs.width == rhs.width && lhs.height == rhs.height
    }
}
