//
//  Vector.swift
//
//
//  Created by Giovani Schiar on 06/12/22.
//

struct Vector: Tag {
    var viewBox: [Double]
    var content: [any Tag]
    
    init(viewBox: [Double], @TagBuilder content: () -> [any Tag]) {
        self.viewBox = viewBox
        self.content = content()
            .parentCoordinates((0, 0))
            .parentDimension(Dimension(width: viewBox[2], height: viewBox[3]))
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
