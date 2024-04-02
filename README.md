# Syntax Highlighting MarkdownUI

## About This Project

Provide a syntax highlighting service for the [MarkdownUI](https://github.com/gonzalezreal/swift-markdown-ui) framework.

## Framework Used

- [SwiftTreeSitter](https://github.com/ChimeHQ/SwiftTreeSitter)
- [Tree Sitter](https://tree-sitter.github.io/tree-sitter/)

## Requirements

- [MarkdownUI](https://github.com/gonzalezreal/swift-markdown-ui)

## Usage

```swift
import Foundation
import MarkdownUI
import SwiftUI
import SyntaxHighlightingMarkdownUI

struct MarkdownCodeSyntaxHightlighter: CodeSyntaxHighlighter {
    func highlightCode(_ content: String, language: String?) -> Text {
        guard let language = language else {
            return Text(content)
        }
        do {
            return try SyntaxHighlightingMarkdownUI.shared.output(content, language: language, theme: MarkdownTheme.xcodeColors())
        } catch {
            print(error)
            return Text(content)
        }
    }
}

extension CodeSyntaxHighlighter where Self == MarkdownCodeSyntaxHightlighter {
    static func syntaxHighlightingMarkdownUI() -> Self {
        MarkdownCodeSyntaxHightlighter()
    }
}
```

```swift
import SwiftUI
import MarkdownUI

struct MyView: View {
    let value: String = "# Title"

    var body: some View {
        Markdown(value)
            .markdownCodeSyntaxHighlighter(.syntaxHighlightingMarkdownUI())
    }
}
```

## Add Languages Configuration

For example: Adding `Zig` syntax highlighting 

Steps
1. Find `Zig` github repo from [Tree Sitter](https://tree-sitter.github.io/tree-sitter/) website
2. Go to [Zig Tree Sitter](https://github.com/maxxnino/tree-sitter-zig) repo
3. Copy the repo URL to Xcode Package Manager and add the package 
4. Import it to your file. Also, you have to import `tree_sitter`
```swift
import TreeSitterZig
import tree_sitter
```
5. Add new configuration to SyntaxHighlightingMarkdownUI
```swift
SyntaxHighlightingMarkdownUI.shared.addConfiguration(name: "zig", tree_sitter_zig())
```
6. If the configuration is added successfully, the function will return true; otherwise, it will return false

## Custom Theme

Create Custom Theme


```swift
public extension MarkdownTheme {
    static func myCustomTheme() -> MarkdownTheme {
        let redPink = Color(red: 242/255, green: 36/255, blue: 140/255)
        let cadetGrey = Color(red: 142/255, green: 161/255, blue: 181/255)
        let mediumTurquoise = Color(red: 86/255, green: 208/255, blue: 179/255)
        let red = Color(red: 252/255, green: 70/255, blue: 81/255)
        
        var theme = MarkdownTheme()
        theme.variable = VariableElement(default: .white, builtin: redPink)
        theme.constant = Constant(default: .white, builtin: red, macro: .white)
        theme.module = Module(default: .white, builtin: .white)
        theme.label = Label(default: .white)
        theme.string = StringElement(default: red, special: StringElement.Special(default: .white))
        theme.character = Character(default: Color(red: 255/255, green: 231/255, blue: 109/255), special: .white)
        theme.boolean = Boolean(default: redPink)
        theme.number = Number(default: Color(red: 255/255, green: 231/255, blue: 109/255), float: .white)
        theme.type = `Type`(default: Color(red: 102/255, green: 218/255, blue: 255/255), builtin: mediumTurquoise, definition: Color(red: 171/255, green: 100/255, blue: 255/255), qualifier: .white)
        theme.attribute = Attribute(default: Color(red: 224/255, green: 157/255, blue: 101/255))
        theme.property = Property(default: mediumTurquoise)
        theme.function = Function(default: mediumTurquoise,
                                  builtin: mediumTurquoise,
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
```

Use Custom Theme

```swift
SyntaxHighlightingMarkdownUI.shared.output(content, language: language, theme: MarkdownTheme.myCustomTheme())
```
