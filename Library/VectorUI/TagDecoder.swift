//
//  TagDecoder.swift
//
//
//  Created by Giovani Schiar on 06/12/22.
//

import class Foundation.XMLDocument
import class Foundation.XMLNode

/// A decoder class responsible for converting `Tag` elements into either SVG or Vector Drawable XML code.
struct TagDecoder {
    
    
    /// Decodes the provided `tag` element into the specified `xmlType` (SVG or Vector Drawable).
    /// - Parameters:
    ///   - tag: The `Tag` element to decode.
    ///   - xmlType: The target XML type (`SVGType` or `VectorDrawableType`).
    /// - Returns: A string containing the generated XML code representing the decoded `tag`.
    func decode(_ tag: any Tag, xmlType: XMLType) -> String {
        return tag.decode(xmlType: xmlType)
    }
    
    /// Decodes and formats the provided `tag` element into the specified `xmlType` (SVG or Vector Drawable) with user-defined formatting options.
    /// - Parameters:
    ///   - tag: The `Tag` element to decode and format.
    ///   - xmlType: The target XML type (`SVGType` or `VectorDrawableType`).
    ///   - options: The formatting options for the generated XML (defaults to compact empty elements and pretty printing).
    /// - Returns: A prettified string containing the generated XML code representing the decoded `tag`.
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
