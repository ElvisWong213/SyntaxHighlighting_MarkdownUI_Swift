//
//  MarkdownTheme.swift
//
//
//  Created by Elvis on 07/02/2024.
//

import Foundation
import SwiftUI

public struct MarkdownTheme: PropertyReflectable {
    public var variable: VariableElement?
    public var constant: Constant?
    public var module: Module?
    public var label: Label?
    public var string: StringElement?
    public var character: Character?
    public var boolean: Boolean?
    public var number: Number?
    public var type: `Type`?
    public var attribute: Attribute?
    public var property: Property?
    public var function: Function?
    public var constructor: Constructor?
    public var `operator`: Operator?
    public var keyword: Keyword?
    public var punctuation: Punctuation?
    public var comment: Comment?
    public var markup: Markup?
    public var tag: Tag?
    public var local: Local?
    
    public init() {
        self.variable = nil
        self.constant = nil
        self.module = nil
        self.label = nil
        self.string = nil
        self.character = nil
        self.boolean = nil
        self.number = nil
        self.type = nil
        self.attribute = nil
        self.property = nil
        self.function = nil
        self.constructor = nil
        self.`operator` = nil
        self.keyword = nil
        self.punctuation = nil
        self.comment = nil
        self.markup = nil
        self.tag = nil
        self.local = nil
    }
    
    func getColor(_ str: String) -> Color? {
        var stringArray = str.split(separator: ".")
        let firstToken = stringArray.removeFirst()
        guard let element = self[String(firstToken)] as? TreeSitterElement else {
            return nil
        }
        return element.toColor(&stringArray)
    }
}

public extension MarkdownTheme {
    static func xcodeColors() -> MarkdownTheme {
        let redPink = Color(red: 242/255, green: 36/255, blue: 140/255)
        let cadetGrey = Color(red: 142/255, green: 161/255, blue: 181/255)
        let mediumTurquoise = Color(red: 86/255, green: 208/255, blue: 179/255)
        
        var theme = MarkdownTheme()
        theme.variable = VariableElement(default: .white, builtin: redPink)
        theme.constant = Constant(default: .white, builtin: .white, macro: .white)
        theme.module = Module(default: .white, builtin: .white)
        theme.label = Label(default: .white)
        theme.string = StringElement(default: Color(red: 252/255, green: 70/255, blue: 81/255), special: StringElement.Special(default: .white))
        theme.character = Character(default: Color(red: 255/255, green: 231/255, blue: 109/255), special: .white)
        theme.boolean = Boolean(default: redPink)
        theme.number = Number(default: Color(red: 255/255, green: 231/255, blue: 109/255), float: .white)
        theme.type = `Type`(default: Color(red: 102/255, green: 218/255, blue: 255/255), builtin: .white, definition: Color(red: 171/255, green: 100/255, blue: 255/255), qualifier: .white)
        theme.attribute = Attribute(default: Color(red: 224/255, green: 157/255, blue: 101/255))
        theme.property = Property(default: mediumTurquoise)
        theme.function = Function(default: mediumTurquoise,
                                  builtin: .white,
                                  call: Color(red: 208/255, green: 168/255, blue: 255/255),
                                  macro: .white,
                                  method: Function.Method(default: redPink, call: Color(red: 171/255, green: 100/255, blue: 255/255)))
        theme.constructor = Constructor(default: redPink)
        theme.operator = Operator(default: .white)
        theme.keyword = Keyword(default: redPink,
                                coroutine: .white,
                                function: redPink,
                                operator: .white,
                                import: redPink,
                                storage: .white,
                                repeat: .white,
                                return: redPink,
                                debug: .white,
                                exception: .white,
                                directive: Keyword.Directive(default: .red, define: .white),
                                conditional: Keyword.Conditional(default: .yellow, ternary: .white))
        theme.punctuation = Punctuation(delimiter: .white, bracket: .white, special: .white)
        theme.comment = Comment(default: cadetGrey,
                                documentation: cadetGrey,
                                error: .red,
                                warning: .yellow,
                                todo: .orange,
                                note: cadetGrey)
        theme.markup = Markup(strong: cadetGrey,
                              italic: cadetGrey,
                              strikethrough: cadetGrey,
                              underline: cadetGrey,
                              heading: cadetGrey,
                              quote: cadetGrey,
                              math: cadetGrey,
                              environment: cadetGrey,
                              link: Markup.TreesitterLink(default: .blue, label: .blue, url: .blue),
                              raw: Markup.Raw(default: .white, block: .white),
                              list: Markup.TreesitterList(default: .white, checked: .white, unchecked: .white))
        theme.tag = Tag(name: .purple, attribute: .white, delimiter: .white)
        theme.local = Local(definition: Local.Definition(import: redPink))
        return theme
    }
}
