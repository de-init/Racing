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
}

extension HomeViewController: MenuViewDelegate {
    func didTapPlayButton() {
        let vc = GameViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
