//
//  TagDecoder.swift
//
//
//  Created by Giovani Schiar on 06/12/22.
//

import class Foundation.XMLDocument
import class Foundation.XMLNode

struct TagDecoder {
    func decode(_ tag: any Tag, xmlType: XMLType) -> String {
        return tag.decode(xmlType: xmlType)
    }
    
    func prettyDecode(_ tag: any Tag, xmlType: XMLType, options: XMLNode.Options = [.nodeCompactEmptyElement, .nodePrettyPrint]) -> String {
        let xmlString = tag.decode(xmlType: xmlType)
        do {
            let xml = try XMLDocument.init(xmlString: xmlString)
            let data = xml.xmlData(options: options)
            let str:String? = String(data: data, encoding: .utf8)
            return str ?? xmlString
        }
        catch {
          print(error.localizedDescription)
        }
        return xmlString
    }
}
