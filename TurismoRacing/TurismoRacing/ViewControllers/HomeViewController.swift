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
    var coordinator: Coordinator?

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
        coordinator?.displayLeaderboardScreen()
        dismiss(animated: false)
    }
    
    func didTapSettingsButton() {
        coordinator?.displaySettingScreen()
        dismiss(animated: false)
    }
    
    func didTapPlayButton() {
        coordinator?.displayGameScreen()
        dismiss(animated: false)
    }
    func didTapInfoButton() {
        self.showInfoViewControllerSheet()
    }
}
