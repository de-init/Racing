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
    private var backgroundImageArray: [UIImageView]!
    private var car: UIImageView!
    private var lable: UILabel!
    private var scoreLable: UILabel!
    private var gameOver = false
    private var scoreCountTimer: Timer!
    private var points = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackToView()
        startLable()
        createScoreLable()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.7) {
            self.timerCount()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }
    
    // MARK: - Timer
    private func timerCount() {
        scoreCountTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countPoints), userInfo: nil, repeats: true)
    }
    @objc private func countPoints() {
        if gameOver == false {
            points += 1
            scoreLable.text = "\(Strings.score.localized): \(points)"
        } else {
            scoreCountTimer.invalidate()
        }
    }
    private func createScoreLable() {
        let color = CGColor(red: 0, green: 0, blue: 0, alpha: 0.37)
        let strokeTextAttributes = [
            NSAttributedString.Key.strokeColor : UIColor.init(hex: 0xE8E5DA),
            NSAttributedString.Key.foregroundColor : UIColor.init(hex: 0x648DE5),
            NSAttributedString.Key.strokeWidth : -3.0,
            NSAttributedString.Key.font : UIFont(name: Fonts.HammersmithOne.regular.fontName, size: 35)]
        as [NSAttributedString.Key : Any]
        scoreLable = UILabel()
        scoreLable.adjustsFontSizeToFitWidth = true
        scoreLable.numberOfLines = 0
        scoreLable.layer.backgroundColor = color
        scoreLable.layer.cornerRadius = 15
        scoreLable.attributedText = NSMutableAttributedString(string: "\(Strings.score.localized)", attributes: strokeTextAttributes)
        view.addSubview(scoreLable)
    }
    // MARK: - Start timer
    private func startLable() {
        lable = UILabel()
        lable.text = "3"
        lable.font = UIFont.boldSystemFont(ofSize: 86)
        lable.textColor = UIColor.init(hex: 0xD9F339)
        lable.numberOfLines = 0
        lable.textAlignment = .center
        view.addSubview(lable)
        animateStartLable()
    }
    private func animateStartLable() {
        UIView.animate(withDuration: 1, delay: 0) {
            self.lable.transform = CGAffineTransform(scaleX: 2, y: 2)
            self.lable.layer.opacity = 0.2
        } completion: { _ in
            self.lable.transform = .identity
            self.lable.text = "2"
            self.lable.layer.opacity = 1
            UIView.animate(withDuration: 1, delay: 0) {
                self.lable.transform = CGAffineTransform(scaleX: 2, y: 2)
                self.lable.layer.opacity = 0.2
            } completion: { _ in
                self.lable.transform = .identity
                self.lable.text = "1"
                self.lable.layer.opacity = 1
                UIView.animate(withDuration: 1, delay: 0) {
                    self.lable.transform = CGAffineTransform(scaleX: 2, y: 2)
                    self.lable.layer.opacity = 0.2
                } completion: { _ in
                    self.lable.transform = .identity
                    self.lable.layer.opacity = 1
                    self.lable.text = "GOOO!"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        self.lable.isHidden = true
                    }
                }
            }
        }
    }
    
    // MARK: - Add Game View
    private func addBackToView() {
        backgroundImageArray = [backImage(backName: "ic_desertMap1"), backImage(backName: "ic_desertMap2"), backImage(backName: "ic_desertMap3")]
        backgroundImageArray[0].frame.origin = .zero
        backgroundImageArray[1].frame.origin = CGPoint(x: 0, y: 0 - view.bounds.height)
        view.addSubview(backgroundImageArray[0])
        view.addSubview(backgroundImageArray[1])
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.7) {
            self.animateBackground()
            self.addSwipeRecognizer()
            self.addObjectsToRoad()
        }
        addCarToView()
    }
    private func addCarToView() {
        let carName = Globals.userDefaults.object(forKey: "CarModel")
        let defaultCar = "ic_defaultCar"
        car = carImage(carName: "\(carName ?? defaultCar)")
        car.isUserInteractionEnabled = true
        car.center = CGPoint(x: view.bounds.midX / 2, y: view.bounds.maxY - 100)
        view.addSubview(car)
    }
    // MARK: - Work With Animation
    private func animateBackground() {
        let animator = UIViewPropertyAnimator(duration: 5, curve: .linear) {
            self.backgroundImageArray[0].frame.origin = CGPoint(x: 0, y: self.view.bounds.maxY)
            self.backgroundImageArray[1].frame.origin = .zero
        }
        animator.addCompletion { _ in
            self.workAnimate()
        }
        if gameOver == false {
            animator.startAnimation()
        } else if gameOver == true {
            animator.stopAnimation(true)
        }
    }
    private func workAnimate() {
        backgroundImageArray[0].removeFromSuperview()
        backgroundImageArray.append(backgroundImageArray.removeFirst())
        view.insertSubview(backgroundImageArray[1], belowSubview: car)
        backgroundImageArray[1].frame.origin = CGPoint(x: 0, y: 0 - view.bounds.height)
        animateBackground()
    }
    // MARK: - Add Objects and Animate
    private func addObjectsToRoad() {
        workFirstObject()
        workSecondObject()
        workThirdObject()
        workFourthObject()
    }
    
    private func workFirstObject() {
        let randomDelay = Double.random(in: 0...6)
        let objectImagesArrayCopy = Images().objectArray
        let item = objectImagesArrayCopy.randomElement()
        item!.center = CGPoint(x: view.bounds.midX / 2, y: 0 - 40)
        animateFirstObject(element: item!, point: CGPoint(x: view.bounds.midX / 2, y: view.bounds.maxY - 170) , delay: randomDelay)
    }
    private func workSecondObject() {
        let randomDelay = Double.random(in: 0...6)
        let objectImagesArrayCopy = Images().objectArray
        let item = objectImagesArrayCopy.randomElement()
        item!.center = CGPoint(x: view.bounds.midX / 2 + view.bounds.midX / 3, y: 0 - 40)
        animateSecondObject(element: item!, point: CGPoint(x: view.bounds.midX / 2 + view.bounds.midX / 3, y: view.bounds.maxY - 170), delay: randomDelay)
    }
    private func workThirdObject() {
        let randomDelay = Double.random(in: 0...6)
        let objectImagesArrayCopy = Images().objectArray
        let item = objectImagesArrayCopy.randomElement()
        item!.center = CGPoint(x: view.bounds.maxX / 3 + view.bounds.midX / 2, y: 0 - 40)
        animateThirdObject(element: item!, point: CGPoint(x: view.bounds.maxX / 3 + view.bounds.midX / 2, y: view.bounds.maxY - 170), delay: randomDelay)
    }
    private func workFourthObject() {
        let randomDelay = Double.random(in: 0...6)
        let objectImagesArrayCopy = Images().objectArray
        let item = objectImagesArrayCopy.randomElement()
        item!.center = CGPoint(x: view.bounds.maxX / 2 + view.bounds.midX / 2, y: 0 - 40)
        animateFourthObject(element: item!, point: CGPoint(x: view.bounds.maxX / 2 + view.bounds.midX / 2, y: view.bounds.maxY - 170), delay: randomDelay)
    }
    private func animateFirstObject(element: UIImageView, point: CGPoint, delay: Double) {
        UIView.animate(withDuration: 4.5, delay: delay, options: .curveLinear) {
            element.center = point
        } completion: { _ in
            if self.car.frame.intersects(self.car.convert(element.frame, to: self.car)) {
                self.car.layer.presentation()
                self.view.layer.removeAllAnimations()
                self.gameFinish()
            } else if self.gameOver {
                self.view.layer.removeAllAnimations()
                element.removeFromSuperview()
            } else {
                element.removeFromSuperview()
                self.workFirstObject()
            }
        }
        view.addSubview(element)
    }
    private func animateSecondObject(element: UIImageView, point: CGPoint, delay: Double) {
        UIView.animate(withDuration: 4.5, delay: delay, options: .curveLinear) {
            element.center = point
        } completion: { _ in
            if self.car.frame.intersects(self.car.convert(element.frame, to: self.car)) {
                self.car.layer.presentation()
                self.view.layer.removeAllAnimations()
                self.gameFinish()
            } else if self.gameOver {
                self.view.layer.removeAllAnimations()
                element.removeFromSuperview()
            } else {
                element.removeFromSuperview()
                self.workSecondObject()
            }
        }
        view.insertSubview(element, belowSubview: scoreLable)
    }
    private func animateThirdObject(element: UIImageView, point: CGPoint, delay: Double) {
        UIView.animate(withDuration: 4.5, delay: delay, options: .curveLinear) {
            element.center = point
        } completion: { _ in
            if self.car.frame.intersects(self.car.convert(element.frame, to: self.car)) {
                self.car.layer.presentation()
                self.view.layer.removeAllAnimations()
                self.gameFinish()
            } else if self.gameOver {
                self.view.layer.removeAllAnimations()
                element.removeFromSuperview()
            } else {
                element.removeFromSuperview()
                self.workThirdObject()
            }
        }
        view.insertSubview(element, belowSubview: scoreLable)
    }
    private func animateFourthObject(element: UIImageView, point: CGPoint, delay: Double) {
        UIView.animate(withDuration: 4.5, delay: delay, options: .curveLinear) {
            element.center = point
        } completion: { _ in
            if self.car.frame.intersects(self.car.convert(element.frame, to: self.car)) {
                self.car.layer.presentation()
                self.view.layer.removeAllAnimations()
                self.gameFinish()
            } else if self.gameOver {
                self.view.layer.removeAllAnimations()
                element.removeFromSuperview()
            } else {
                element.removeFromSuperview()
                self.workFourthObject()
            }
        }
        view.addSubview(element)
    }
    private func gameFinish() {
        gameOver = true
        var scores: [Int] = Globals.userDefaults.object(forKey: "score") as? [Int] ?? []
        if points > 0 {
            scores.append(points)
            Globals.userDefaults.set(scores, forKey: "score")
        }
    }
    
    // MARK: - Control Car
    private func addSwipeRecognizer() {
        setupRightRecognizer()
        setupLeftRecognizer()
    }
    private func setupRightRecognizer() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(moveCar))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    private func setupLeftRecognizer() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(moveCar))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
    }
    @objc private func moveCar(sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            car.center.x -= view.bounds.midX / 3
        } else if sender.direction == .right {
            car.center.x += view.bounds.midX / 3
        }
    }
    // MARK: - Init images
    private func backImage(backName: String) -> UIImageView {
        let image = UIImage(named: backName)
        let imageView = UIImageView(image: image)
        imageView.frame = view.bounds
        return imageView
    }
    private func carImage(carName: String) -> UIImageView {
        let image = UIImage(named: carName)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    // MARK: - Setup Constraints
    private func setupConstraints() {
        setupLableConstraints()
        setupScoreLableConstraints()
    }
    private func setupLableConstraints() {
        lable.snp.makeConstraints { make in
            make.centerX.equalTo(view.center)
            make.centerY.equalTo(view.center)
        }
    }
    private func setupScoreLableConstraints() {
        scoreLable.snp.makeConstraints { make in
            make.centerX.equalTo(view.center)
            make.top.equalTo(view).offset(40)
        }
    }
}


