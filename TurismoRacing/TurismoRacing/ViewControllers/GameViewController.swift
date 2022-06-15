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
    
    private let backgroundImages = ["ic_desertMap1", "ic_desertMap2", "ic_desertMap3"]
    private var backgroundImageArray: [UIImageView] = []
    private let objectImages = ["ic_barrel", "ic_barrier", "ic_cone", "ic_coin"]
    private var objectImagesArray: [UIImageView] = []
    private var car: UIImageView!
    private var randomObject: UIImageView!
    private var randomObject2: UIImageView!
    private var randomObject3: UIImageView!
    private var randomObject4: UIImageView!
    private var lable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTimer()
        addBackToView()
        startLable()
    }
    
    private func startLable() {
        lable = UILabel()
        lable.text = "3"
        lable.font = UIFont.boldSystemFont(ofSize: 86)
        lable.textColor = .white
        lable.numberOfLines = 0
        lable.textAlignment = .center
        view.addSubview(lable)
        lable.snp.makeConstraints { make in
            make.centerX.equalTo(view.center)
            make.centerY.equalTo(view.center)
        }
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
    
    private func createTimer() {
        let timer = Timer.scheduledTimer(timeInterval: 7,
                                         target: self,
                                         selector: #selector(addObjectsToRoad),
                                         userInfo: nil,
                                         repeats: true)
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
            self.addObjectsToRoad()
            self.swipeRecognizer()
        }
        addCarToView()
    }
    
    private func addCarToView() {
        car = carImage(carName: "ic_car")
        car.isUserInteractionEnabled = true
        car.center = CGPoint(x: view.bounds.midX / 2, y: view.bounds.maxY - 100)
        view.addSubview(car)
    }
    
    // MARK: - Work With Animation
    
    private func animateBackground() {
        UIView.animate(withDuration: 5, delay: 0, options: .curveLinear) {
            self.backgroundImageArray[0].frame.origin = CGPoint(x: 0, y: self.view.bounds.maxY)
            self.backgroundImageArray[1].frame.origin = .zero
        } completion: { _ in
            self.workAnimate()
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
    
    @objc private func addObjectsToRoad() {
        objectImagesArray = [objectImage(name: "ic_barrel"), objectImage(name: "ic_barrier"), objectImage(name: "ic_cone"), objectImage(name: "ic_coin")]
        randomObject = objectImagesArray.randomElement()
        randomObject.center = CGPoint(x: view.bounds.midX / 2, y: 0 - 40)
        randomObject2 = objectImagesArray.randomElement()
        randomObject2.center = CGPoint(x: view.bounds.midX / 2 + view.bounds.midX / 3, y: 0 - 40)
        randomObject3 = objectImagesArray.randomElement()
        randomObject3.center = CGPoint(x: view.bounds.maxX / 3 + view.bounds.midX / 2, y: 0 - 40)
        randomObject4 = objectImagesArray.randomElement()
        randomObject4.center = CGPoint(x: view.bounds.maxX / 2 + view.bounds.midX / 2, y: 0 - 40)
        animateObject(element: randomObject, point: CGPoint(x: view.bounds.midX / 2, y: view.bounds.maxY - 200))
        animateObject(element: randomObject2, point: CGPoint(x: view.bounds.midX / 2 + view.bounds.midX / 3, y: view.bounds.maxY - 200))
        animateObject(element: randomObject3, point: CGPoint(x: view.bounds.maxX / 3 + view.bounds.midX / 2, y: view.bounds.maxY - 200))
        animateObject(element: randomObject4, point: CGPoint(x: view.bounds.maxX / 2 + view.bounds.midX / 2, y: view.bounds.maxY - 200))
    }
    
    private func animateObject(element: UIImageView, point: CGPoint) {
        UIView.animate(withDuration: 4.3, delay: 0, options: .curveLinear) {
            element.center = point
        } completion: { _ in
            if element.center.x == self.car.center.x {
            }
            element.removeFromSuperview()
        }
        view.addSubview(element)
    }
    
    // MARK: - Control Car
    
    private func swipeRecognizer() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(moveCar))
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(moveCar))
        swipeLeft.direction = .left
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
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
    
    private func objectImage(name: String) -> UIImageView {
        let image = UIImage(named: name)
        let imageView = UIImageView(image: image)
        return imageView
    }
}
