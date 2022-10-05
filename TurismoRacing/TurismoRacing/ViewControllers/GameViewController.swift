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
    private var gameView: GameView!
    private var pauseView: PauseView!
    private var navBar: CustomNavigationBar!
    private var backgroundView: UIView!
    private var backgroundImages: [UIImageView] = []
    private var backgroundAnimator = UIViewPropertyAnimator()
    private var car: Car!
    var coordinator: Coordinator?
    
    override func loadView() {
        let nView = UIView(frame: UIScreen.main.bounds)
        view = nView
        setUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateBackground(duration: 3)
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
        setPauseView()
    }
    
    private func setGameView() {
        gameView = GameView()
        view.addSubview(gameView)
    }
    
    private func setPauseView() {
        pauseView = PauseView()
        view.addSubview(pauseView)
    }
    
    private func setBackgroundMap() {
        backgroundView = UIView(frame: view.frame)
        backgroundView.clipsToBounds = true
        backgroundImages = GameManager.shared.loadMap()
        backgroundImages[0].frame.origin = .zero
        backgroundImages[1].frame.origin = CGPoint(x: 0, y: 0 - view.bounds.height)
        view.addSubview(backgroundView)
        backgroundView.addSubview(backgroundImages[0])
        backgroundView.addSubview(backgroundImages[1])
    }
    
    private func setNavigationBar() {
        let leftItem = CustomNavigationBarItem(imageName: "backButtonImage", itemAction: { [weak self] in
            self?.coordinator?.stepBack() })
        let rightItem = CustomNavigationBarItem(imageName: "pauseButtonImage", itemAction: { self.playButtonTap() })
        let bar = CustomNavigationBar(leftItem: leftItem, rightItem: rightItem, titleText: "")
        bar.translatesAutoresizingMaskIntoConstraints = false
        navBar = bar
        view.addSubview(navBar)
    }
    
    //MARK: - Animate Background
    
    private func animateBackground(duration: TimeInterval) {
        backgroundAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear, animations: {
            self.backgroundImages[0].frame.origin = CGPoint(x: 0, y: self.view.bounds.maxY)
            self.backgroundImages[1].frame.origin = .zero
        })
        backgroundAnimator.startAnimation()
        backgroundAnimator.addCompletion ({ _ in
            self.changeBackground()
        })
    }
    
    private func changeBackground() {
        self.backgroundImages[0].removeFromSuperview()
        self.backgroundImages.append(backgroundImages.removeFirst())
        self.backgroundView.addSubview(backgroundImages[1])
        self.backgroundImages[1].frame.origin = CGPoint(x: 0, y: 0 - self.view.bounds.maxY)
        animateBackground(duration: 3)
    }

    //MARK: - Layout
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setFrameGameView()
        setConstraintsNavigationBar()
        setConstraintsPauseView()
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
    
    private func setConstraintsPauseView() {
        pauseView.snp.makeConstraints { make in
            make.height.equalTo(350)
            make.width.equalTo(300)
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
    }
    
    // MARK: - Helper Methods
    
    private func delay(delay: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
}

//MARK: - Extension

extension GameViewController: PauseViewDelegate {
    func playButtonTap() {
        pauseView.isHidden.toggle()
    }
    
    func exitButtonTap() {
    }
}
