//
//  TreeSitterElement.swift
//
//
//  Created by Elvis on 17/02/2024.
//

import Foundation
import SwiftUI

public protocol TreeSitterElement {
    func toColor(_ str: [Substring], _ index: Int) -> Color?
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
    
    public func toColor(_ str: [Substring], _ index: Int) -> Color? {
        switch str.getElement(index) {
        case "builtin":
            return builtin
        case "parameter":
            return parameter
        case "member":
            return member
        default:
            return `default`
        }
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
    
    public func toColor(_ str: [Substring], _ index: Int) -> Color? {
        switch str.getElement(index) {
        case "builtin":
            return builtin
        case "macro":
            return macro
        default:
            return `default`
        }
    }
}

public struct Module: TreeSitterElement {
    let `default`: Color
    let builtin: Color?
    
    public init(`default`: Color, builtin: Color? = nil) {
        self.default = `default`
        self.builtin = builtin
    }
    
    public func toColor(_ str: [Substring], _ index: Int) -> Color? {
        switch str.getElement(index) {
        case "builtin":
            return builtin
        default:
            return `default`
        }
    }
}

public struct Label: TreeSitterElement {
    let `default`: Color
    
    public init(`default`: Color) {
        self.default = `default`
    }
    
    public func toColor(_ str: [Substring], _ index: Int) -> Color? {
        return `default`
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
    
    public func toColor(_ str: [Substring], _ index: Int) -> Color? {
        switch str.getElement(index) {
        case "documentation":
            return documentation
        case "regexp":
            return regexp
        case "escape":
            return escape
        case "special":
            return special.toColor(str, index + 1)
        default:
            return `default`
        }
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
        
        public func toColor(_ str: [Substring], _ index: Int) -> Color? {
            switch str.getElement(index) {
            case "symbol":
                return symbol
            case "url":
                return url
            case "path":
                return path
            default:
                return `default`
            }
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
    
    public func toColor(_ str: [Substring], _ index: Int) -> Color? {
        switch str.getElement(index) {
        case "special":
            return special
        default:
            return `default`
        }
    }
}

public struct Boolean: TreeSitterElement {
    let `default`: Color
    
    public init(`default`: Color) {
        self.default = `default`
    }
    
    public func toColor(_ str: [Substring], _ index: Int) -> Color? {
        return `default`
    }
}

public struct Number: TreeSitterElement {
    let `default`: Color
    let float: Color?
    
    public init(`default`: Color, float: Color? = nil) {
        self.default = `default`
        self.float = float
    }
    
    public func toColor(_ str: [Substring], _ index: Int) -> Color? {
        switch str.getElement(index) {
        case "float":
            return float
        default:
            return `default`
        }
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
    
    public func toColor(_ str: [Substring], _ index: Int) -> Color? {
        switch str.getElement(index) {
        case "builtin":
            return builtin
        case "definition":
            return definition
        case "qualifier":
            return qualifier
        default:
            return `default`
        }
    }
}

public struct Attribute: TreeSitterElement {
    let `default`: Color
    
    public init(`default`: Color) {
        self.default = `default`
    }
    
    public func toColor(_ str: [Substring], _ index: Int) -> Color? {
        return `default`
    }
}

public struct Property: TreeSitterElement {
    let `default`: Color
    
    public init(`default`: Color) {
        self.default = `default`
    }
    
    public func toColor(_ str: [Substring], _ index: Int) -> Color? {
        return `default`
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
    
    public func toColor(_ str: [Substring], _ index: Int) -> Color? {
        switch str.getElement(index) {
        case "builtin":
            return builtin
        case "call":
            return call
        case "macro":
            return macro
        case "method":
            return method.toColor(str, index + 1)
        default:
            return `default`
        }
    }
    
    public struct Method: TreeSitterElement {
        let `default`: Color
        let call: Color?
        
        public init(`default`: Color, call: Color? = nil) {
            self.default = `default`
            self.call = call
        }
        
        public func toColor(_ str: [Substring], _ index: Int) -> Color? {
            switch str.getElement(index) {
            case "call":
                return call
            default:
                return `default`
            }
        }
    }
}

public struct Constructor: TreeSitterElement {
    let `default`: Color
    
    public init(`default`: Color) {
        self.default = `default`
    }
    
    public func toColor(_ str: [Substring], _ index: Int) -> Color? {
        return `default`
    }
}

public struct Operator: TreeSitterElement {
    let `default`: Color
    
    public init(`default`: Color) {
        self.default = `default`
    }
    
    public func toColor(_ str: [Substring], _ index: Int) -> Color? {
        return `default`
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
    
    public func toColor(_ str: [Substring], _ index: Int) -> Color? {
        switch str.getElement(index) {
        case "coroutine":
            return coroutine
        case "function":
            return function
        case "operator":
            return `operator`
        case "import":
            return `import`
        case "storage":
            return storage
        case "repeat":
            return `repeat`
        case "return":
            return `return`
        case "debug":
            return debug
        case "exception":
            return exception
        case "directive":
            return directive.toColor(str, index + 1)
        case "conditional":
            return conditional.toColor(str, index + 1)
        default:
            return `default`
        }
    }
    
    public struct Conditional: TreeSitterElement {
        let `default`: Color
        let ternary: Color?
        
        public init(`default`: Color, ternary: Color? = nil) {
            self.default = `default`
            self.ternary = ternary
        }
        
        public func toColor(_ str: [Substring], _ index: Int) -> Color? {
            switch str.getElement(index) {
            case "ternary":
                return ternary
            default:
                return `default`
            }
        }
    }
    
    public struct Directive: TreeSitterElement {
        let `default`: Color
        let define: Color?
        
        public init(`default`: Color, define: Color? = nil) {
            self.default = `default`
            self.define = define
        }
        
        public func toColor(_ str: [Substring], _ index: Int) -> Color? {
            switch str.getElement(index) {
            case "define":
                return define
            default:
                return `default`
            }
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
    
    public func toColor(_ str: [Substring], _ index: Int) -> Color? {
        switch str.getElement(index) {
        case "delimiter":
            return delimiter
        case "bracket":
            return bracket
        case "special":
            return special
        default:
            return nil
        }
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
    
    public func toColor(_ str: [Substring], _ index: Int) -> Color? {
        switch str.getElement(index) {
        case "documentation":
            return documentation
        case "error":
            return error
        case "warning":
            return warning
        case "todo":
            return todo
        case "note":
            return note
        default:
            return `default`
        }
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
    
    public func toColor(_ str: [Substring], _ index: Int) -> Color? {
        switch str.getElement(index) {
        case "strong":
            return strong
        case "italic":
            return italic
        case "strikethrough":
            return strikethrough
        case "underline":
            return underline
        case "heading":
            return heading
        case "quote":
            return quote
        case "math":
            return math
        case "environment":
            return environment
        case "link":
            return link.toColor(str, index + 1)
        case "raw":
            return raw.toColor(str, index + 1)
        case "list":
            return list.toColor(str, index + 1)
        default:
            return nil
        }
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
        
        public func toColor(_ str: [Substring], _ index: Int) -> Color? {
            switch str.getElement(index) {
            case "label":
                return label
            case "url":
                return url
            default:
                return `default`
            }
        }
    }
    
    public struct Raw: TreeSitterElement {
        let `default`: Color
        let block: Color?
        
        public init(`default`: Color, block: Color? = nil) {
            self.default = `default`
            self.block = block
        }
        
        public func toColor(_ str: [Substring], _ index: Int) -> Color? {
            switch str.getElement(index) {
            case "block":
                return block
            default:
                return `default`
            }
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
        
        public func toColor(_ str: [Substring], _ index: Int) -> Color? {
            switch str.getElement(index) {
            case "checked":
                return checked
            case "unchecked":
                return unchecked
            default:
                return `default`
            }
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
    
    public func toColor(_ str: [Substring], _ index: Int) -> Color? {
        switch str.getElement(index) {
        case "name":
            return name
        case "attribute":
            return attribute
        case "delimiter":
            return delimiter
        default:
            return nil
        }
    }
}
