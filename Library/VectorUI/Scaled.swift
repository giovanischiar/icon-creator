//
//  Scaled.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

protocol Scaled {
    associatedtype T
    func scaled(factor: Double) -> T
}
