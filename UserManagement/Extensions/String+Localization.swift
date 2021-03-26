//
//  String+Localization.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/20.
//

import Foundation

extension String {
    var localized: String {
//        return NSLocalizedString(self,
//                                 tableName: "Localizable",
//                                 bundle: .main,
//                                 value: self,
//                                 comment: self)
        let path = Bundle.main.path(forResource: AppSettings.shared.appInfo.language, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: bundle!,
                                 value: self,
                                 comment: self)
    }
}
