//
//  AppSettings.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/22.
//

import Foundation
import RealmSwift

class AppSettings {
    static let shared: AppSettings = AppSettings()
//    var appMainColor: UIColor = .systemYellow
//    var appAppearance: UIUserInterfaceStyle = .unspecified
    var appInfo: AppInfo {
        let defaults = UserDefaults.standard
        let info = AppInfo(language: defaults.string(forKey: "language").as(String()),
                           userInterfaceStyle: defaults.integer(forKey: "userInterfaceStyle"),
                           mainColor: defaults.integer(forKey: "mainColor"))
        return info
    }
    
    var realm: Realm {
        return try! Realm(configuration: Realm.Configuration(objectTypes: [RealmUserModel.self,
                                                                    NameModel.self,
                                                                    LocationModel.self,
                                                                    StreetModel.self,
                                                                    CoordinatesModel.self,
                                                                    TimezoneModel.self,
                                                                    LoginModel.self,
                                                                    DobModel.self,
                                                                    IDModel.self,
                                                                    PictureModel.self]))
    }
}
