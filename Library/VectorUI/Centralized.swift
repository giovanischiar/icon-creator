//
//  Centralized.swift
//  
//
//  Created by Giovani Schiar on 05/12/22.
//

protocol Centralized {
    associatedtype T
    func center() -> T
    func parentDimension(_ value: Dimension) -> T
}
