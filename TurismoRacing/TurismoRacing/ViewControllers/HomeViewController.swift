//
//  HomeViewController.swift
//  TurismoRacing
//
//  Created by S2 on 15.06.22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    private let homeView = HomeMenu()
    private var maxScore: Int!

    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.delegate = self
    }
    
    // MARK: - Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
    private func setupLayout() {
        makeLayoutHomeView()
    }
    private func makeLayoutHomeView() {
        homeView.frame = view.bounds
    }
    
    // MARK: - Private Methods
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setBestScore()
    }
    private func setBestScore() {
        guard let scoreArray = Globals.userDefaults.object(forKey: "score") as? [Int] else { return }
        maxScore = scoreArray.max()
        DispatchQueue.main.async {
            self.homeView.updateScore(score: self.maxScore)
        }
    }
    private func showInfoViewControllerSheet() {
        let viewControllerToPresent = InfoButtonSheetViewController()
        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(viewControllerToPresent, animated: true, completion: nil)
    }
}

// MARK: - Extensions
extension HomeViewController: MenuViewDelegate {
    func didTapLeaderboardButton() {
        let leaderboard = LeaderBoardViewController()
        navigationController?.pushViewController(leaderboard, animated: true)
    }
    
    func didTapSettingsButton() {
        let settings = SettingsViewController()
        navigationController?.pushViewController(settings, animated: true)
    }
    
    func didTapPlayButton() {
        let game = GameViewController()
        navigationController?.pushViewController(game, animated: true)
    }
    func didTapInfoButton() {
        self.showInfoViewControllerSheet()
    }
}
