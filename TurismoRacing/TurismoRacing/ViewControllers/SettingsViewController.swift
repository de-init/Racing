//
//  SettingsViewController.swift
//  TurismoRacing
//
//  Created by S2 on 23.06.22.
//

import UIKit

class SettingsViewController: UIViewController {
    private var settingsView = SettingsView()
    
    override func loadView() {
        view = settingsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.delegate = self
    }
    // MARK: - Layout
    override func viewDidLayoutSubviews() {
        settingsView.frame = view.frame
    }
}
// MARK: - Extensions
extension SettingsViewController: SettingsViewDelegate {
    func didEasyButtonTapped() {
        Manager.userDefaults.set(true, forKey: "Easy")
        Manager.userDefaults.set(false, forKey: "Medium")
        Manager.userDefaults.set(false, forKey: "Hard")
        settingsView.animateSelection()
    }
    
    func didMediumButtonTapped() {
        Manager.userDefaults.set(false, forKey: "Easy")
        Manager.userDefaults.set(true, forKey: "Medium")
        Manager.userDefaults.set(false, forKey: "Hard")
        settingsView.animateSelection()
    }

    func didHardButtonTapped() {
        Manager.userDefaults.set(false, forKey: "Easy")
        Manager.userDefaults.set(false, forKey: "Medium")
        Manager.userDefaults.set(true, forKey: "Hard")
        settingsView.animateSelection()
    }
}
