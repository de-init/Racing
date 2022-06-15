//
//  ViewController.swift
//  TurismoRacing
//
//  Created by S2 on 14.06.22.
//

import UIKit

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
    }
    
    private func createTimer() {
        let timer = Timer.scheduledTimer(timeInterval: 7,
                                         target: self,
                                         selector: #selector(addObjectsToRoad),
                                         userInfo: nil,
                                         repeats: true)
    }
    
    private func addBackToView() {
        backgroundImageArray = [backImage(backName: "ic_desertMap1"), backImage(backName: "ic_desertMap2"), backImage(backName: "ic_desertMap3")]
        backgroundImageArray[0].frame.origin = .zero
        backgroundImageArray[1].frame.origin = CGPoint(x: 0, y: 0 - view.bounds.height)
        view.addSubview(backgroundImageArray[0])
        view.addSubview(backgroundImageArray[1])
        animateBackground()
        addObjectsToRoad()
        swipeRecognizer()
        addCarToView()
    }
    
    private func addCarToView() {
        car = carImage(carName: "ic_car")
        car.isUserInteractionEnabled = true
        car.center = CGPoint(x: view.bounds.midX / 2, y: view.bounds.maxY - 100)
        view.addSubview(car)
    }
    
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
    
    @objc private func addObjectsToRoad() {
        objectImagesArray = [objectImage(name: "ic_barrel"), objectImage(name: "ic_barrier"), objectImage(name: "ic_cone"), objectImage(name: "ic_coin")]
        randomObject = objectImagesArray.randomElement()
        randomObject?.center = CGPoint(x: view.bounds.midX / 2, y: 0 - 40)
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
    // MARK: -
    
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
    // MARK: -
    
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
