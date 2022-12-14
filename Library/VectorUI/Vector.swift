//
//  Vector.swift
//
//
//  Created by Giovani Schiar on 06/12/22.
//

struct Vector: Tag {
    var viewBox: [Double]? = nil
    var content: [any Tag]
    
    init(viewBox: [Double]? = nil, @TagBuilder content: () -> [any Tag]) {
        self.viewBox = viewBox
        self.content = content()
    }
    
    var body: [any Tag] { content }
    
    func name(xmlType: XMLType) -> String { xmlType.vector }
    
    func params(xmlType: XMLType) -> String {
        var dict = [String: Any]()
        dict = dict.merging(xmlType.viewBox(values: viewBox)) { (_, new) in new }
        dict[xmlType.xmlns] = xmlType.namespace

        return dict.map { (key: String, value: Any) in
            "\(key)=\"\(value)\""
        }.lazy.joined(separator: " ")
    }
}
