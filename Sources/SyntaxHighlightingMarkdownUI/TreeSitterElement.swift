//
//  TreeSitterElement.swift
//
//
//  Created by Elvis on 17/02/2024.
//

import Foundation
import SwiftUI

public protocol TreeSitterElement: PropertyReflectable {
    func toColor(_ str: inout [Substring]) -> Color?
}

extension TreeSitterElement {
    public func toColor(_ str: inout [Substring]) -> Color? {
        if str.isEmpty {
            return self["default"] as? Color
        }
        let token = String(str.removeFirst())
        if let element = self[token] as? TreeSitterElement {
            return element.toColor(&str)
        }
        if let element = self[token] as? Color {
            return element
        }
        return self["default"] as? Color
    }
}

public struct VariableElement: TreeSitterElement {
    let `default`: Color
    let builtin: Color?
    let parameter: Color?
    let member: Color?
    
    public init(`default`: Color, builtin: Color? = nil, parameter: Color? = nil, member: Color? = nil) {
        self.default = `default`
        self.builtin = builtin
        self.parameter = parameter
        self.member = member
    }
}

public struct Constant: TreeSitterElement {
    let `default`: Color
    let builtin: Color?
    let macro: Color?
    
    public init(`default`: Color, builtin: Color? = nil, macro: Color? = nil) {
        self.default = `default`
        self.builtin = builtin
        self.macro = macro
    }
}

public struct Module: TreeSitterElement {
    let `default`: Color
    let builtin: Color?
    
    public init(`default`: Color, builtin: Color? = nil) {
        self.default = `default`
        self.builtin = builtin
    }
}

public struct Label: TreeSitterElement {
    let `default`: Color
    
    public init(`default`: Color) {
        self.default = `default`
    }
}

public struct StringElement: TreeSitterElement {
    let `default`: Color
    let documentation: Color?
    let regexp: Color?
    let escape: Color?
    let special: Special
    
    public init(`default`: Color, documentation: Color? = nil, regexp: Color? = nil, escape: Color? = nil, special: Special) {
        self.default = `default`
        self.documentation = documentation
        self.regexp = regexp
        self.escape = escape
        self.special = special
    }
    
    public struct Special: TreeSitterElement {
        let `default`: Color
        let symbol: Color?
        let url: Color?
        let path: Color?
        
        public init(`default`: Color, symbol: Color? = nil, url: Color? = nil, path: Color? = nil) {
            self.default = `default`
            self.symbol = symbol
            self.url = url
            self.path = path
        }
    }
}

public struct Character: TreeSitterElement {
    let `default`: Color
    let special: Color?
    
    public init(`default`: Color, special: Color? = nil) {
        self.default = `default`
        self.special = special
    }
}

public struct Boolean: TreeSitterElement {
    let `default`: Color
    
    public init(`default`: Color) {
        self.default = `default`
    }
}

public struct Number: TreeSitterElement {
    let `default`: Color
    let float: Color?
    
    public init(`default`: Color, float: Color? = nil) {
        self.default = `default`
        self.float = float
    }
}

public struct `Type`: TreeSitterElement {
    let `default`: Color
    let builtin: Color?
    let definition: Color?
    let qualifier: Color?
    
    public init(`default`: Color, builtin: Color? = nil, definition: Color? = nil, qualifier: Color? = nil) {
        self.default = `default`
        self.builtin = builtin
        self.definition = definition
        self.qualifier = qualifier
    }
}

public struct Attribute: TreeSitterElement {
    let `default`: Color
    
    public init(`default`: Color) {
        self.default = `default`
    }
}

public struct Property: TreeSitterElement {
    let `default`: Color
    
    public init(`default`: Color) {
        self.default = `default`
    }
}

public struct Function: TreeSitterElement {
    let `default`: Color
    let builtin: Color?
    let call: Color?
    let macro: Color?
    let method: Method
    
    public init(`default`: Color, builtin: Color? = nil, call: Color? = nil, macro: Color? = nil, method: Method) {
        self.default = `default`
        self.builtin = builtin
        self.call = call
        self.macro = macro
        self.method = method
    }
    
    public struct Method: TreeSitterElement {
        let `default`: Color
        let call: Color?
        
        public init(`default`: Color, call: Color? = nil) {
            self.default = `default`
            self.call = call
        }
    }
}

public struct Constructor: TreeSitterElement {
    let `default`: Color
    
    public init(`default`: Color) {
        self.default = `default`
    }
}

public struct Operator: TreeSitterElement {
    let `default`: Color
    
    public init(`default`: Color) {
        self.default = `default`
    }
}

public struct Keyword: TreeSitterElement {
    let `default`: Color
    let coroutine: Color?
    let function: Color?
    let `operator`: Color?
    let `import`: Color?
    let storage: Color?
    let `repeat`: Color?
    let `return`: Color?
    let debug: Color?
    let exception: Color?
    let directive: Directive
    let conditional: Conditional
    
    public init(`default`: Color, coroutine: Color? = nil, function: Color? = nil, `operator`: Color? = nil, `import`: Color? = nil, storage: Color? = nil, `repeat`: Color? = nil, `return`: Color? = nil, debug: Color? = nil, exception: Color? = nil, directive: Directive, conditional: Conditional) {
        self.default = `default`
        self.coroutine = coroutine
        self.function = function
        self.operator = `operator`
        self.import = `import`
        self.storage = storage
        self.repeat = `repeat`
        self.return = `return`
        self.debug = debug
        self.exception = exception
        self.directive = directive
        self.conditional = conditional
    }
    
    public struct Conditional: TreeSitterElement {
        let `default`: Color
        let ternary: Color?
        
        public init(`default`: Color, ternary: Color? = nil) {
            self.default = `default`
            self.ternary = ternary
        }
    }
    
    public struct Directive: TreeSitterElement {
        let `default`: Color
        let define: Color?
        
        public init(`default`: Color, define: Color? = nil) {
            self.default = `default`
            self.define = define
        }
    }
}

public struct Punctuation: TreeSitterElement {
    let delimiter: Color?
    let bracket: Color?
    let special: Color?
    
    public init(delimiter: Color? = nil, bracket: Color? = nil, special: Color? = nil) {
        self.delimiter = delimiter
        self.bracket = bracket
        self.special = special
    }
}

public struct Comment: TreeSitterElement {
    let `default`: Color
    let documentation: Color?
    let error: Color?
    let warning: Color?
    let todo: Color?
    let note: Color?
    
    public init(`default`: Color, documentation: Color? = nil, error: Color? = nil, warning: Color? = nil, todo: Color? = nil, note: Color? = nil) {
        self.default = `default`
        self.documentation = documentation
        self.error = error
        self.warning = warning
        self.todo = todo
        self.note = note
    }
}

public struct Markup: TreeSitterElement {
    let strong: Color?
    let italic: Color?
    let strikethrough: Color?
    let underline: Color?
    let heading: Color?
    let quote: Color?
    let math: Color?
    let environment: Color?
    let link: TreesitterLink
    let raw: Raw
    let list: TreesitterList
    
    public init(strong: Color? = nil, italic: Color? = nil, strikethrough: Color? = nil, underline: Color? = nil, heading: Color? = nil, quote: Color? = nil, math: Color? = nil, environment: Color? = nil, link: TreesitterLink, raw: Raw, list: TreesitterList) {
        self.strong = strong
        self.italic = italic
        self.strikethrough = strikethrough
        self.underline = underline
        self.heading = heading
        self.quote = quote
        self.math = math
        self.environment = environment
        self.link = link
        self.raw = raw
        self.list = list
    }
    
    public struct TreesitterLink: TreeSitterElement {
        let `default`: Color
        let label: Color?
        let url: Color?
        
        public init(`default`: Color, label: Color? = nil, url: Color? = nil) {
            self.default = `default`
            self.label = label
            self.url = url
        }
    }
    
    public struct Raw: TreeSitterElement {
        let `default`: Color
        let block: Color?
        
        public init(`default`: Color, block: Color? = nil) {
            self.default = `default`
            self.block = block
        }
    }
    
    public struct TreesitterList: TreeSitterElement {
        let `default`: Color
        let checked: Color?
        let unchecked: Color?
        
        public init(`default`: Color, checked: Color? = nil, unchecked: Color? = nil) {
            self.default = `default`
            self.checked = checked
            self.unchecked = unchecked
        }
    }
}

public struct Tag: TreeSitterElement {
    let name: Color?
    let attribute: Color?
    let delimiter: Color?
    
    public init(name: Color? = nil, attribute: Color? = nil, delimiter: Color? = nil) {
        self.name = name
        self.attribute = attribute
        self.delimiter = delimiter
    }
}

public struct Local: TreeSitterElement {
    public let definition: Definition
    public let scope: Color?
    public let reference: Color?
    
    public init(definition: Definition, scope: Color? = nil, reference: Color? = nil) {
        self.definition = definition
        self.scope = scope
        self.reference = reference
    }
    
    public struct Definition: TreeSitterElement {
        public let constant: Color?
        public let function: Color?
        public let method: Color?
        public let variable: Color?
        public let parameter: Color?
        public let macro: Color?
        public let type: Color?
        public let field: Color?
        public let `enum`: Color?
        public let namespace: Color?
        public let `import`: Color?
        public let associated: Color?
        
        public init(constant: Color? = nil, function: Color? = nil, method: Color? = nil, variable: Color? = nil, parameter: Color? = nil, macro: Color? = nil, type: Color? = nil, field: Color? = nil, enum: Color? = nil, namespace: Color? = nil, import: Color? = nil, associated: Color? = nil) {
              self.constant = constant
              self.function = function
              self.method = method
              self.variable = variable
              self.parameter = parameter
              self.macro = macro
              self.type = type
              self.field = field
              self.enum = `enum`
              self.namespace = namespace
              self.import = `import`
              self.associated = associated
          }
    }
}
