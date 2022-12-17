//
//  ColorsResParser.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

import Foundation

class ColorsResParser: NSObject, XMLParserDelegate {
    var dictReady: (Result<[String: String], Error>) -> Void = { _ in }
    var xmlColorsDict: [String: String] = [:]
    private var currentKey = ""
    
    func parseXMLValues() async throws -> [String: String] {
        return try await withCheckedThrowingContinuation({
                (continuation: CheckedContinuation<[String: String], Error>) in self.parseXMLValues(path: MainTraits.shared.iconPaletteFile) {
                    continuation.resume(with: $0)
                }
            }
        )
    }
    
    private func parseXMLValues(path: String, dictReady: @escaping (Result<[String: String], Error>) -> Void) {
        self.dictReady = dictReady
        guard let xmlParser = XMLParser(contentsOf: URL(fileURLWithPath: path)) else { return }
        xmlParser.delegate = self
        xmlParser.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if(elementName == "color") {
            if let colorName = attributeDict["name"] {
                currentKey = colorName
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if (currentKey != "" && xmlColorsDict[currentKey] == nil) {
            xmlColorsDict[currentKey] = string
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        dictReady(.success(xmlColorsDict))
    }
}
