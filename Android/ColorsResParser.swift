//
//  ColorsResParser.swift
//
//
//  Created by Giovani Schiar on 13/12/22.
//

import Foundation

/// Parses the XML of the color resources file.
class ColorsResParser: NSObject, XMLParserDelegate {
    private var dictReady: (Result<[String: String], Error>) -> Void = { _ in }
    private var xmlColorsDict: [String: String] = [:]
    private var currentKey = ""
    
    
    /// Parses the color key-value pairs from the colors resource file.
    /// - Parameter path: The path to the colors resource file (`Colors.xml`).
    /// - Returns: The dictionary with the values parsed.
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
    
    /// Method from protocol XMLParserDelegate
    /// - Parameters:
    ///   - parser: The XMLParser object.
    ///   - elementName: The XML element name.
    ///   - namespaceURI: The namespace URI.
    ///   - qName: The qualified name.
    ///   - attributeDict: The attribute dictionary.
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if(elementName == "color") {
            if let colorName = attributeDict["name"] {
                currentKey = colorName
            }
        }
    }
    
    /// Method from protocol XMLParserDelegate
    /// - Parameters:
    ///   - parser: The XMLParser object.
    ///   - string: The found characters.
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if (currentKey != "" && xmlColorsDict[currentKey] == nil) {
            xmlColorsDict[currentKey] = string
        }
    }
    
    /// Method from protocol XMLParserDelegate
    /// - Parameter parser: The XMLParser object.
    func parserDidEndDocument(_ parser: XMLParser) {
        dictReady(.success(xmlColorsDict))
    }
}
