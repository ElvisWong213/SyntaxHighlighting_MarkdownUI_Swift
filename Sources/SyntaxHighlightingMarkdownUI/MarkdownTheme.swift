//
//  MarkdownTheme.swift
//
//
//  Created by Elvis on 07/02/2024.
//

import Foundation
import SwiftUI

public struct MarkdownTheme {
    public var tokens: [TokenType : TreeSitterElement]
    
    public init(tokens: [TokenType : TreeSitterElement]) {
        self.tokens = tokens
    }
    
    func getColor(_ str: String) -> Color? {
        let stringArray = str.split(separator: ".")
        guard let firstToken = stringArray.first else {
            return nil
        }
        guard let tokenType = TokenType(rawValue: String(firstToken)) else {
            return nil
        }
        guard let element = tokens[tokenType] else {
            return nil
        }
        return element.toColor(stringArray, 1)
    }
}

public extension MarkdownTheme {
    static func xcodeColors() -> MarkdownTheme {
        return MarkdownTheme(
            tokens: [
                .variable: 
                    VariableElement(
                        default: .white,
                        builtin: .white,
                        parameter: .white,
                        member: .white
                    ),
                .constant: 
                    Constant(
                        default: .white,
                        builtin: .white,
                        macro: .white
                    ),
                .module: 
                    Module(
                        default: .white,
                        builtin: .white
                    ),
                .label: Label(default: .white),
                .string: 
                    StringElement(
                        default: Color(red: 252/255, green: 70/255, blue: 81/255),
                        documentation: .white,
                        regexp: .white,
                        escape: .white,
                        special:
                            StringElement.Special(
                                default: .white,
                                symbol: .white,
                                url: .white,
                                path: .white
                            )
                    ),
                .character:
                    Character(
                        default: Color(red: 255/255, green: 231/255, blue: 109/255),
                        special: .white
                    ),
                .boolean: Boolean(default: Color(red: 242/255, green: 36/255, blue: 140/255)),
                .number:
                    Number(
                        default: Color(red: 255/255, green: 231/255, blue: 109/255),
                        float: .white
                    ),
                .type:
                    `Type`(
                        default: Color(red: 102/255, green: 218/255, blue: 255/255),
                        builtin: .white,
                        definition: .white,
                        qualifier: .white
                    ),
                .attribute: Attribute(default: Color(red: 224/255, green: 157/255, blue: 101/255)),
                .property: Property(default: Color(red: 86/255, green: 208/255, blue: 179/255)),
                .function:
                    Function(
                        default: Color(red: 86/255, green: 208/255, blue: 179/255),
                        builtin: .white,
                        call: .white,
                        macro: .white,
                        method:
                            Function.Method(
                                default: .white,
                                call: .white
                            )
                    ),
                .constructor: Constructor(default: Color(red: 242/255, green: 36/255, blue: 140/255)),
                .`operator`: Operator(default: .white),
                .keyword:
                    Keyword(
                        default: Color(red: 242/255, green: 36/255, blue: 140/255),
                        coroutine: .white,
                        function: .white,
                        operator: .white,
                        import: .white,
                        storage: .white,
                        repeat: .white,
                        return: .white,
                        debug: .white,
                        exception: .white,
                        directive: 
                            Keyword.Directive(
                                default: .red,
                                define: .white
                            ),
                        conditional:
                            Keyword.Conditional(
                                default: .yellow,
                                ternary: .white
                            )
                    ),
                .punctuation:
                    Punctuation(
                        delimiter: .white,
                        bracket: .white,
                        special: .white
                    ),
                .comment:
                    Comment(
                        default: Color(red: 142/255, green: 161/255, blue: 181/255),
                        documentation: Color(red: 142/255, green: 161/255, blue: 181/255),
                        error: .red,
                        warning: .yellow,
                        todo: .orange,
                        note: Color(red: 142/255, green: 161/255, blue: 181/255)
                    ),
                .markup:
                    Markup(
                        strong: Color(red: 142/255, green: 161/255, blue: 181/255),
                        italic: Color(red: 142/255, green: 161/255, blue: 181/255),
                        strikethrough: Color(red: 142/255, green: 161/255, blue: 181/255),
                        underline: Color(red: 142/255, green: 161/255, blue: 181/255),
                        heading: Color(red: 142/255, green: 161/255, blue: 181/255),
                        quote: Color(red: 142/255, green: 161/255, blue: 181/255),
                        math: Color(red: 142/255, green: 161/255, blue: 181/255),
                        environment: Color(red: 142/255, green: 161/255, blue: 181/255),
                        link: Markup.TreesitterLink(default: .blue, label: .blue, url: .blue),
                        raw: Markup.Raw(default: .white, block: .white),
                        list: Markup.TreesitterList(default: .white, checked: .white, unchecked: .white)
                    ),
                .tag: Tag(name: .purple, attribute: .white, delimiter: .white),
            ]
        )
    }
}

public enum TokenType: String, CaseIterable {
    case variable, constant, module, label, string, character, boolean, number, type, attribute, property, function, constructor, `operator`, keyword, punctuation, comment, markup, tag
}
