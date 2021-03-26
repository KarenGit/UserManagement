//
//  SettingsViewModel.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/24.
//

import UIKit

struct SettingsViewModel {
    
    
    // MARK: - Methods -
    
    func changeLanguage(with forResource: String) {
        UserDefaults.standard.set(forResource, forKey: "language")
    }
    
    func changeAppearance(with index: Int) {
        let style = UIUserInterfaceStyle(rawValue: index)
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = style!
        }
    }
    
    func changeMainCollor(with selectedButton: UIButton) {
        
    }
}
