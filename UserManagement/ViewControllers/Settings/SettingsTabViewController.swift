//
//  SettingsTabViewController.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/20.
//

import UIKit

class SettingsTabViewController: UIViewController {
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var languageSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var appearanceLabel: UILabel!
    @IBOutlet private weak var appearanceSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var mainColorLabel: UILabel!
    @IBOutlet private weak var yellowButton: UIButton!
    @IBOutlet private weak var blueButton: UIButton!
    @IBOutlet private weak var cyanButton: UIButton!
    @IBOutlet weak var versionLabel: UILabel!
    private var changeMainCollorButtons = [UIButton]()
    private let defaults = UserDefaults.standard
    let settingsViewModel = SettingsViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.configureSegmentedControls()
        self.configureChangeMainCollorButtons()
        self.localization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = Constants.Localization.settings.localized
    }
    
    
    // MARK: - Private Methods -
    
    private func configureView() {
        let appInfo = AppSettings.shared.appInfo
        self.languageSegmentedControl.selectedSegmentIndex = (appInfo.language == "hy" ? 1 : 0)
        self.appearanceSegmentedControl.selectedSegmentIndex = appInfo.userInterfaceStyle
        
        guard let mainColor = appInfo.mainColor.getMainColor else { return }
        
        self.setAppMainColor(with: mainColor)
    }
    
    private func configureSegmentedControls() {
        self.languageSegmentedControl.setTitle(Constants.Localization.english.localized, forSegmentAt: 0)
        self.languageSegmentedControl.setTitle(Constants.Localization.armenian.localized, forSegmentAt: 1)
        self.appearanceSegmentedControl.setTitle(Constants.Localization.light.localized, forSegmentAt: 0)
        self.appearanceSegmentedControl.setTitle(Constants.Localization.dark.localized, forSegmentAt: 1)
        self.appearanceSegmentedControl.setTitle(Constants.Localization.auto.localized, forSegmentAt: 2)
    }
    
    private func configureChangeMainCollorButtons() {
        self.changeMainCollorButtons = [self.yellowButton,
                                        self.blueButton,
                                        self.cyanButton]
        let selectedButtonIndex = AppSettings.shared.appInfo.mainColor
        self.changeMainCollorButtons[selectedButtonIndex].backgroundColor = (selectedButtonIndex).getMainColor
    }
    
    private func setAppMainColor(with mainColor: UIColor) {
        self.tabBarController?.tabBar.tintColor = mainColor
        self.navigationController?.navigationBar.tintColor = mainColor
        self.languageSegmentedControl.selectedSegmentTintColor = mainColor
        self.appearanceSegmentedControl.selectedSegmentTintColor = mainColor
    }
    
    private func localization() {
        self.languageLabel.text = Constants.Localization.language.localized
        self.appearanceLabel.text = Constants.Localization.appearance.localized
        self.mainColorLabel.text = Constants.Localization.mainColor.localized
        guard
            let build = Bundle.main.buildVersionNumber,
            let version = Bundle.main.releaseVersionNumber else { return }
        
        self.versionLabel.text = Constants.Localization.appVersion.localized + " \(version).\(build)"
    }
    
    @IBAction private func languageSegmentedControlAction(_ sender: UISegmentedControl) {
        let language = (sender.selectedSegmentIndex == 0 ? "en" : "hy")
        self.settingsViewModel.changeLanguage(with: language)
        self.localization()
        self.configureSegmentedControls()
        self.navigationController?.navigationBar.topItem?.title = Constants.Localization.settings.localized
        // TODO: - need update tabBar texts -
        //        self.tabBarController?.tabBar
    }
    
    @IBAction private func appearanceSegmentedControlAction(_ sender: UISegmentedControl) {
        let selectedIndex = (sender.selectedSegmentIndex == 2
                                ? 0
                                : sender.selectedSegmentIndex + 1)
        self.defaults.set(sender.selectedSegmentIndex, forKey: "userInterfaceStyle")
        self.settingsViewModel.changeAppearance(with: selectedIndex)
    }
    
    
    
    @IBAction private func changeMainCollorButtonsAction(_ sender: UIButton) {
        self.defaults.set(sender.tag, forKey: "mainColor")
        for button in self.changeMainCollorButtons {
            if button == sender {
                if let mainColor = AppSettings.shared.appInfo.mainColor.getMainColor {
                    button.backgroundColor = mainColor
                    self.setAppMainColor(with: mainColor)
                }
            } else {
                button.backgroundColor = .systemBackground
            }
        }
    }
}
