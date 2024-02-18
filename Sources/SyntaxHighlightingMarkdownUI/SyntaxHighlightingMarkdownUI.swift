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
    private var swiftConfiguration: LanguageConfiguration? = nil
    private var javaConfiguration: LanguageConfiguration? = nil
    private var jsConfiguration: LanguageConfiguration? = nil
    private var rustConfiguration: LanguageConfiguration? = nil
        
    public static let shared: SyntaxHighlightingMarkdownUI = SyntaxHighlightingMarkdownUI()
            
    private init() {
        do {
            self.swiftConfiguration = try LanguageConfiguration(tree_sitter_swift(), name: "Swift")
            self.javaConfiguration = try LanguageConfiguration(tree_sitter_java(), name: "Java")
            self.jsConfiguration = try LanguageConfiguration(tree_sitter_javascript(), name: "JS")
            self.rustConfiguration = try LanguageConfiguration(tree_sitter_rust(), name: "Rust")
        } catch {
            print(error)
        }
    }
    
    public func output(_ content: String, language: String, theme: MarkdownTheme = MarkdownTheme.xcodeColors()) throws -> Text {
        let languageConfiguration: LanguageConfiguration = try getLanguageConfiguration(language)
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
    
    private func getLanguageConfiguration(_ language: String) throws -> LanguageConfiguration {
        switch language.lowercased() {
        case "swift":
            guard let swiftConfiguration = swiftConfiguration else {
                throw SyntaxHighlightingError.LanguageConfigurationError
            }
            return swiftConfiguration
        case "java":
            guard let javaConfiguration = javaConfiguration else {
                throw SyntaxHighlightingError.LanguageConfigurationError
            }
            return javaConfiguration
        case "javascript":
            guard let jsConfiguration = jsConfiguration else {
                throw SyntaxHighlightingError.LanguageConfigurationError
            }
            return jsConfiguration
        case "rust":
            guard let rustConfiguration = rustConfiguration else {
                throw SyntaxHighlightingError.LanguageConfigurationError
            }
            return rustConfiguration
        default: throw SyntaxHighlightingError.UnsupportedFormatError
        }
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
