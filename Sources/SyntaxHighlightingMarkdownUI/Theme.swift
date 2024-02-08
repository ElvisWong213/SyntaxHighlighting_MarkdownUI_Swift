//
//  Theme.swift
//
//
//  Created by Elvis on 07/02/2024.
//

import Foundation
import SwiftUI

struct Theme {
    var tokens: [TokenType : Color]
}

extension Theme {
    static func xcodeColors() -> Theme {
        return Theme(
            tokens: [
                .variable: Color.white,
                .constant: Color.white,
                .module: Color.white,
                .label: Color.white,
                .string: Color(red: 252/255, green: 70/255, blue: 81/255),
                .character: Color(red: 255/255, green: 231/255, blue: 109/255),
                .boolean: Color(red: 242/255, green: 36/255, blue: 140/255),
                .number: Color(red: 255/255, green: 231/255, blue: 109/255),
                .type: Color(red: 102/255, green: 218/255, blue: 255/255),
                .attribute: Color(red: 224/255, green: 157/255, blue: 101/255),
                .property: Color(red: 86/255, green: 208/255, blue: 179/255),
                .function: Color(red: 86/255, green: 208/255, blue: 179/255),
                .constructor: Color(red: 242/255, green: 36/255, blue: 140/255),
                .`operator`: Color.white,
                .keyword: Color(red: 242/255, green: 36/255, blue: 140/255),
                .punctuation: Color.white,
                .comment: Color(red: 142/255, green: 161/255, blue: 181/255),
                .markup: Color(red: 142/255, green: 161/255, blue: 181/255),
                .diff: Color.white,
                .tag: Color.purple,
            ]
        )
    }
}

enum TokenType: String, CaseIterable {
    case variable, constant, module, label, string, character, boolean, number, type, attribute, property, function, constructor, `operator`, keyword, punctuation, comment, markup, diff, tag
}

