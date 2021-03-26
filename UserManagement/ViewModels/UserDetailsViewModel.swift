//
//  UserDetailsViewModel.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/24.
//

import Foundation
import UIKit

struct UserDetailsViewModel {
    private var realm = AppSettings().realm
    var userModel: UserModel
    
    init(_ userModel: UserModel) {
        self.userModel = userModel
    }
    
    
    // MARK: - Methods -
    
    func seveUserAction(_ user: User) {
        let userModel = RealmManager.addUserModel(user)
        self.realm.beginWrite()
        self.realm.add(userModel)
        try! self.realm.commitWrite()
    }
    
    func deleteUserModel(_ user: User) {
        DispatchQueue.main.async {
            autoreleasepool {
                let model = self.realm.objects(RealmUserModel.self).filter({ (userModel) -> Bool in
                    user.email == userModel.email
                })
                if !model.isEmpty {
                    try! self.realm.write {
                        self.realm.delete(model)
                    }
                }
            }
        }
    }
    
    func callToUserPhone(_ phoneNumber: String) {
      if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
        let application: UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
      }
    }
}
