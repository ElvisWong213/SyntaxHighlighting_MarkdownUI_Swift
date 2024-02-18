//
//  File.swift
//  
//
//  Created by Elvis on 17/02/2024.
//

import Foundation

extension Array {
    func getElement(_ index: Int) -> String {
        if self.count == 0 || index >= self.count || index < 0 {
            return ""
        }
        return self[index] as? String ?? ""
    }
}
