//
//  Moved.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

protocol Moved {
    associatedtype T
    func moved(x: Double, y : Double) -> T
}
