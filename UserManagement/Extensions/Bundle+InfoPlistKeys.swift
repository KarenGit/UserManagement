//
//  Bundle+InfoPlistKeys.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/21.
//

import Foundation

extension Bundle {
    enum InfoPlistKeys: String {
        case NewsURLPath
        
        var value: String {
            return Bundle.main.getValueFromInfoPlist(self.rawValue, String.self)!
        }
        
        enum BaseURLs: String, NameDescribable {
            case Development, Production
            
            var value: String {
                return Bundle.main.getValueFromInfoPlist(BaseURLs.typeName, self.rawValue, String.self)!
            }
        }
    }
    
    private func getValueFromInfoPlist<T>(_ key: String, _ valueType: T.Type) -> T? {
        return Bundle.main.infoDictionary?[key] as? T
    }
    
    private func getValueFromInfoPlist<T>(_ keyPath: String, _ key: String, _ valueType: T.Type) -> T? {
        return (Bundle.main.infoDictionary?[keyPath] as? Dictionary<String, Any>)?[key] as? T
    }
}
