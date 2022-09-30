//
//  ViewController.swift
//  TurismoRacing
//
//  Created by S2 on 14.06.22.
//

import UIKit
import Foundation
import SnapKit

class GameViewController: UIViewController {
    private let gameView = GameView()
    private var backgroundImages: [UIImageView] = []
    private var navBar = UIView()
    var coordinator: Coordinator?
    
    override func loadView() {
        let nView = UIView(frame: UIScreen.main.bounds)
        view = nView
        setUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: - UI
    
    private func setUI() {
        setGameView()
        setBackgroundMap()
        setNavigationBar()
    }
    private func setGameView() {
        view.addSubview(gameView)
    }
    
    private func setBackgroundMap() {
        backgroundImages = GameManager.shared.loadMap()
        backgroundImages[0].frame.origin = .zero
        backgroundImages[1].frame.origin = CGPoint(x: 0, y: 0 - view.bounds.size.height)
        view.addSubview(backgroundImages[0])
        view.addSubview(backgroundImages[1])
    }
    
    private func setNavigationBar() {
        let leftItem = CustomNavigationBarItem(imageName: "backButtonImage", itemAction: { [weak self] in
            self?.coordinator?.stepBack() })
        let rightItem = CustomNavigationBarItem(imageName: "pauseButtonImage", itemAction: { return })
        navBar = CustomNavigationBar(leftItem: leftItem, rightItem: rightItem, titleText: "")
        navBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navBar)
    }
    //MARK: - Layout
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setFrameGameView()
        setConstraintsNavigationBar()
    }
    
    private func setFrameGameView() {
        gameView.frame = view.bounds
    }
    
    private func setConstraintsNavigationBar() {
        navBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(44)
            make.width.equalTo(view.bounds.width)
        }
    }
    
    // MARK: - Helper Methods
    private func delay(delay: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
}


