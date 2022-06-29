//
//  HomeViewController.swift
//  TurismoRacing
//
//  Created by S2 on 15.06.22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    private var homeView = HomeMenu()
    private let defaults = UserDefaults.standard

    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeView.frame = view.frame
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let scoreArray = defaults.object(forKey: "score") as? [Int] else {
            return
        }
        let maxScore = scoreArray.max()
        DispatchQueue.main.async {
            self.homeView.bestScoreLable.text = "Best Score: \n \(maxScore!)"
        }
    }
}

extension HomeViewController: MenuViewDelegate {
    func didTapSettingsButton() {
        let settings = SettingsViewController()
        navigationController?.pushViewController(settings, animated: true)
    }
    
    func didTapPlayButton() {
        let game = GameViewController()
        navigationController?.pushViewController(game, animated: true)
    }
}
