//
//  Coordinator.swift
//  TurismoRacing
//
//  Created by S2 on 19.09.22.
//

import Foundation
import UIKit

class Coordinator {
    private let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    func displaySettingScreen() {
        let viewController = SettingsViewController()
        viewController.coordinator = self
        rootViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    func displayGameScreen() {
        let viewController = GameViewController()
        viewController.coordinator = self
        rootViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    func displayLeaderboardScreen() {
        let viewController = LeaderboardViewController()
        viewController.coordinator = self
        rootViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    func stepBack() {
        rootViewController.navigationController?.popViewController(animated: true)
    }
}
