//
//  SettingsViewController.swift
//  TurismoRacing
//
//  Created by S2 on 23.06.22.
//

import UIKit

class SettingsViewController: UIViewController {
    private let settingsView = SettingsView()
    private var navBar = UIView()
    var coordinator: Coordinator?
    
    override func loadView() {
        self.view = settingsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        setupNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupNavigationBar() {
        let leftItem = CustomNavigationBarItem(imageName: "backButtonImage", itemAction: { [weak self] in
            self?.coordinator?.stepBack() })
        let rightItem = CustomNavigationBarItem(imageName: "saveButtonImage", itemAction: { return })
        navBar = CustomNavigationBar(leftItem: leftItem, rightItem: rightItem, titleText: Strings.settings.localized)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navBar)
    }
    // MARK: - Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeFrameSettingsView()
        makeConstraintsNavBar()
    }
    
    private func makeFrameSettingsView() {
        settingsView.frame = view.frame
    }
    
    private func makeConstraintsNavBar() {
        navBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(44)
            make.width.equalTo(view.bounds.width)
        }
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
