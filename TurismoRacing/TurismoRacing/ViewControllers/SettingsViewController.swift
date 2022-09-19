//
//  SettingsViewController.swift
//  TurismoRacing
//
//  Created by S2 on 23.06.22.
//

import UIKit

class SettingsViewController: UIViewController {
    private var settingsView = SettingsView()
    var coordinator: Coordinator?
    
    override func loadView() {
        self.view = settingsView
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
        Globals.userDefaults.set(true, forKey: "Easy")
        Globals.userDefaults.set(false, forKey: "Medium")
        Globals.userDefaults.set(false, forKey: "Hard")
    }
    
    func didMediumButtonTapped() {
        Globals.userDefaults.set(false, forKey: "Easy")
        Globals.userDefaults.set(true, forKey: "Medium")
        Globals.userDefaults.set(false, forKey: "Hard")
    }

    func didHardButtonTapped() {
        Globals.userDefaults.set(false, forKey: "Easy")
        Globals.userDefaults.set(false, forKey: "Medium")
        Globals.userDefaults.set(true, forKey: "Hard")
    }
}
