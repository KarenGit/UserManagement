//
//  Optional+Nil.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/22.
//

import Foundation

extension Optional {
    var isNil: Bool {
        return (self == nil)
    }
    
    var notNil: Bool {
        return !self.isNil
    }
    
    func `as`(_ `default`: Wrapped) -> Wrapped {
        (self ?? `default`)
    }
}
