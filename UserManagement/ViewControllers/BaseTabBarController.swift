//
//  BaseTabBarController.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/20.
//

import UIKit

class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {
    var usersTabViewController = UsersTabViewController()
    var savedTabViewController = UsersTabViewController()
    var settingsTabViewController = SettingsTabViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 0
        self.configureViewControllers()
    }
    
    
    // MARK: - Private Methods -
    
    private func configureViewControllers() {
        self.delegate = self
        self.savedTabViewController.isSaved = true
        
        // Create Tab Users
        let tabUsers = self.usersTabViewController
        let tabUsersBarItem = UITabBarItem(title: Constants.Localization.users.localized,
                                           image: #imageLiteral(resourceName: "UsersImage"), selectedImage: #imageLiteral(resourceName: "FilledUsersImage"))
        tabUsers.tabBarItem = tabUsersBarItem
        // Create Tab Saved
        let tabSaved = self.savedTabViewController
        let tabSavedBarItem = UITabBarItem(title: Constants.Localization.saved.localized,
                                           image: #imageLiteral(resourceName: "HeartImage"), selectedImage: #imageLiteral(resourceName: "FilledHeartImage"))
        tabSaved.tabBarItem = tabSavedBarItem
        // Create Tab Setting
        let tabSetting = self.settingsTabViewController
        let tabSettingBarItem = UITabBarItem(title: Constants.Localization.settings.localized,
                                             image: #imageLiteral(resourceName: "SettingsImage"), selectedImage: #imageLiteral(resourceName: "FilledSettingsImage"))
        tabSetting.tabBarItem = tabSettingBarItem
        
        self.viewControllers = [tabUsers, tabSaved, tabSetting]
        self.tabBar.tintColor = AppSettings.shared.appInfo.mainColor.getMainColor
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(#function)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print(#function)
    }
}

