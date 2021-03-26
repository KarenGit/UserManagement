//
//  Bundle+Version.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/25.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
