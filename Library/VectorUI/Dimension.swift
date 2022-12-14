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
