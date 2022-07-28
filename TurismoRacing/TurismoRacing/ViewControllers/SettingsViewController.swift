//
//  SettingsViewController.swift
//  TurismoRacing
//
//  Created by S2 on 23.06.22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private var settingsView = SettingsView()
    private var userDefaults = UserDefaults.standard
    
    override func loadView() {
        view = settingsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        settingsView.frame = view.frame
    }
}

extension SettingsViewController: SettingsViewDelegate {
    func didEasyButtonTapped() {
        userDefaults.set(true, forKey: "Easy")
        userDefaults.set(false, forKey: "Medium")
        userDefaults.set(false, forKey: "Hard")
        settingsView.animateSelection()
    }
    
    func didMediumButtonTapped() {
        userDefaults.set(false, forKey: "Easy")
        userDefaults.set(true, forKey: "Medium")
        userDefaults.set(false, forKey: "Hard")
        settingsView.animateSelection()
    }

    func didHardButtonTapped() {
        userDefaults.set(false, forKey: "Easy")
        userDefaults.set(false, forKey: "Medium")
        userDefaults.set(true, forKey: "Hard")
        settingsView.animateSelection()
    }
}
