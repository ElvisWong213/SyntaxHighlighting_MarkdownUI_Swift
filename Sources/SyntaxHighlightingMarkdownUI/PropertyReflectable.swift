//
//  PropertyReflectable.swift
//
//
//  Created by Elvis on 18/02/2024.
//

import Foundation

public protocol PropertyReflectable {}

extension PropertyReflectable {
    subscript(key: String) -> Any? {
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            if child.label == key {
                return child.value
            }
        }
        return nil
    }
}
