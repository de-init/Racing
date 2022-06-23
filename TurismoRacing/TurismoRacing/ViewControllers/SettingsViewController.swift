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
    
    override func viewDidLayoutSubviews() {
        settingsView.frame = view.frame
    }
}

extension SettingsViewController: SettingsViewDelegate {
    
}
