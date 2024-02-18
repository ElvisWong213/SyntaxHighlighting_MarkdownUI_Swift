// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import SwiftTreeSitter
import TreeSitterSwift
import TreeSitterJava
import TreeSitterJS
import TreeSitterRust

@available(macOS 12, *)
public class SyntaxHighlightingMarkdownUI {
    private var languagesConfiguration: [String : LanguageConfiguration] = [:]
        
    public static let shared: SyntaxHighlightingMarkdownUI = SyntaxHighlightingMarkdownUI()
            
    private init() {
        do {
            self.languagesConfiguration["swift"] = try LanguageConfiguration(tree_sitter_swift(), name: "Swift")
            self.languagesConfiguration["java"] = try LanguageConfiguration(tree_sitter_java(), name: "Java")
            self.languagesConfiguration["javascript"] = try LanguageConfiguration(tree_sitter_javascript(), name: "JS")
            self.languagesConfiguration["rust"] = try LanguageConfiguration(tree_sitter_rust(), name: "Rust")
        } catch {
            print(error)
        }
    }
    
    public func output(_ content: String, language: String, theme: MarkdownTheme = MarkdownTheme.xcodeColors()) throws -> Text {
        guard let languageConfiguration: LanguageConfiguration = languagesConfiguration[language] else {
            throw SyntaxHighlightingError.UnsupportedFormatError
        }
        let parser: Parser = Parser()
        
        try parser.setLanguage(languageConfiguration.language)
        guard let tree = parser.parse(content) else {
            throw SyntaxHighlightingError.ParseError
        }
        
        guard let query = languageConfiguration.queries[.highlights] else {
            throw SyntaxHighlightingError.QueryEmptyError
        }
        
        guard let treeRootNode = tree.rootNode else {
            throw SyntaxHighlightingError.TreeRootNodeError
        }
        
        let cursor = query.execute(node: treeRootNode, in: tree)
        let resolvingSequence = cursor.resolve(with: Predicate.Context(string: content)).highlights()
        
        var output = AttributedString(content)
        for capture in resolvingSequence {
            guard let range = Range(capture.range, in: AttributedString(content)) else { continue }
            guard let color = theme.getColor(capture.name) else { continue }
            output[range].foregroundColor = color
        }
        return Text(output)
    }
}

public enum SyntaxHighlightingError: LocalizedError {
    case UnsupportedFormatError, ParseError, ResourceError, TreeRootNodeError, QueryEmptyError, LanguageConfigurationError
    
    public var errorDescription: String? {
        switch self {
        case .UnsupportedFormatError:
            return "Unsupported Format"
        case .ParseError:
            return "Unable to Parse Content"
        case .ResourceError:
            return "Unable to Find The Resource"
        case .TreeRootNodeError:
            return "Tree Root Node is Null"
        case .QueryEmptyError:
            return "Quert is Empty"
        case .LanguageConfigurationError:
            return "Language Configuration"
        }
    }
}
