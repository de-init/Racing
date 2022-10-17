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
    private var pauseView: PauseView!
    private var navBar: CustomNavigationBar!
    private var startTimer: StartTimer!
    private var backgroundView: UIView!
    private var backgroundImages: [UIImageView] = []
    private var backgroundAnimator = UIViewPropertyAnimator()
    private var scoreLableView: UIView!
    private var scoreLable: UILabel!
    private var car: Car!
    private var objects: [Object] = []
    private var objectPoints: [CGPoint] = []
    private var objectAnimator = UIViewPropertyAnimator()
    private var timerPutObject = Timer()
    private var timerCheckIntersection = Timer()
    private var game = Game()
    var coordinator: Coordinator?
    
    override func loadView() {
        let nView = UIView(frame: UIScreen.main.bounds)
        view = nView
        setBackgroundMap()
        setNavigationBar()
        setPauseView()
        setScoreLable()
        setStartTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer.animateStart()
        pauseView.delegate = self
        delay(delay: 3.5) {
            self.animateBackground(duration: self.game.gameSpeed)
            self.movingCarGesture()
            self.generateObjectPoint(size: self.car.frame.size)
            self.restartTimer()
            self.startTimer.removeFromSuperview()
        }
        setCar()
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
    
    private func setStartTimer() {
        startTimer = StartTimer()
        view.addSubview(startTimer)
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
    
    private func setCar() {
        car = Car.init(frame: CGRect(x: view.frame.width / 4 * 2, y: backgroundView.bounds.maxY - view.frame.width / 5 - 70, width: view.frame.width / 5 - 5, height: view.frame.width / 3 - 10))
        backgroundView.addSubview(car)
    }
    
    private func setNavigationBar() {
        let leftItem = CustomNavigationBarItem(imageName: "backButtonImage", itemAction: { [weak self] in
            self?.coordinator?.stepBack() })
        let rightItem = CustomNavigationBarItem(imageName: "pauseButtonImage", itemAction: { self.tapOnPause() })
        let bar = CustomNavigationBar(leftItem: leftItem, rightItem: rightItem, titleText: "")
        bar.translatesAutoresizingMaskIntoConstraints = false
        navBar = bar
        view.addSubview(navBar)
    }
    
    private func setScoreLable() {
        let strokeTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor(hex: 0xA3B18A),
            NSAttributedString.Key.font : UIFont(name: Fonts.Poppins.bold.fontName, size: 35) ?? UIFont.systemFont(ofSize: 35)]
        as [NSAttributedString.Key : Any]
        scoreLableView = UIView()
        scoreLableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0).withAlphaComponent(0.37)
        scoreLableView.layer.cornerRadius = 15
        scoreLable = UILabel()
        scoreLable.adjustsFontSizeToFitWidth = true
        scoreLable.numberOfLines = 0
        scoreLable.textAlignment = .center
        scoreLable.attributedText = NSMutableAttributedString(string: "\(Strings.score.localized)", attributes: strokeTextAttributes)
        view.addSubview(scoreLableView)
        scoreLableView.addSubview(scoreLable)
    }
    
    //MARK: - Animate Background
    
    private func animateBackground(duration: TimeInterval) {
        backgroundAnimator = UIViewPropertyAnimator(duration: duration - 0.1, curve: .linear, animations: {
            self.backgroundImages[0].frame.origin = CGPoint(x: 0, y: self.backgroundView.bounds.maxY)
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
        self.backgroundView.insertSubview(backgroundImages[1], belowSubview: car)
        self.backgroundImages[1].frame.origin = CGPoint(x: 0, y: 0 - self.backgroundView.bounds.maxY)
        animateBackground(duration: game.gameSpeed)
    }
    
    //MARK: - Moving Car
    
    private func movingCarGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(moveCar))
        backgroundView.addGestureRecognizer(tap)
    }
    
    @objc private func moveCar(sender: UISwipeGestureRecognizer) {
        let tapDirection = sender.location(in: backgroundView).x
        
        if tapDirection < backgroundView.bounds.midX && car.frame.origin.x > 0 + car.frame.width {
            car.movingCar(direction: -1)
        }
        if tapDirection >= backgroundView.bounds.midX && car.frame.maxX <= view.bounds.maxX - car.frame.width {
            car.movingCar(direction: 1)
        }
    }
    
    //MARK: - Object spawn
    
    private func restartTimer() {
        let randomNum = Double.random(in: self.game.gameSpeed-0.5..<self.game.gameSpeed-0.2)
        timerPutObject = Timer.scheduledTimer(withTimeInterval: TimeInterval(randomNum), repeats: false, block: { _ in
            self.moveObject(duration: self.game.gameSpeed)
            self.checkCollision()
            self.restartTimer()
        })
    }
    
    private func generateObjectPoint(size: CGSize) {
        for i in 1...4 {
            objectPoints.append(CGPoint(x: 2 + size.width * CGFloat(i), y: 0 - size.width))
        }
    }
    
    private func moveObject(duration: TimeInterval) {
        let newObject = Object.generateObject(objectSize: car.frame.size, objectPoints: objectPoints)
        for object in newObject {
            backgroundView.insertSubview(object, belowSubview: car)
        }
        objects += newObject
        objectAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear, animations: {
            for object in newObject {
                object.transform = CGAffineTransform(translationX: 0, y: self.backgroundView.bounds.maxY + object.frame.height)
            }
        })
        objectAnimator.startAnimation()
        objectAnimator.addCompletion({ _ in
            for object in newObject where object.frame.origin.y >= self.backgroundView.frame.minY {
                object.removeFromSuperview()
            }
            self.game.currentScore += 1
            self.scoreLable.text = "\(Strings.score.localized): \(self.game.currentScore)"
        })
    }
    
    //MARK: - Check collision
    
    private func checkCollision() {
        self.timerCheckIntersection = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { timer in
            var tempFrameObjects: [CGRect] = []
            for object in self.objects {
                tempFrameObjects.append(object.layer.presentation()?.frame ?? CGRect(x: 0, y: 0, width: 0, height: 0))
            }
            guard let car = self.car,
                  let tempFrameCar = car.layer.presentation()?.frame else {
                return
            }
            for tempFrameObject in tempFrameObjects {
                if tempFrameCar.intersects(tempFrameObject) {
                    self.objectAnimator.stopAnimation(true)
                    self.backgroundView.isUserInteractionEnabled = false
                    self.car.animator.stopAnimation(true)
                    self.timerPutObject.invalidate()
                    self.backgroundAnimator.stopAnimation(true)
                    timer.invalidate()
                    self.showCrash()
                }
            }
        })
    }
    
    private func showCrash() {
        self.car.image = UIImage(named: "boomImage")
        let animate = UIViewPropertyAnimator(duration: 0.5, curve: .linear, animations: {
            self.car.transform = CGAffineTransform(scaleX: 4, y: 4)
        })
        animate.startAnimation()
        animate.addCompletion { _ in
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
                self.showResultView()
                timer.invalidate()
            }
        }
    }
    
    private func showResultView() {
        let resultView = ResultView()
        view.addSubview(resultView)
        resultView.delegate = self
        resultView.totalScore.text = Strings.totalScore.localized + "\n \(game.currentScore)"
        resultView.recordScore.text = Strings.recordScore.localized + "\n \(getMaxNum())"
        
        resultView.snp.makeConstraints { make in
            make.edges.equalTo(view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    private func checkRecord(record: Int) -> Bool {
        var returnValue = false
        if let score = ResultsManager.savedResults() {
            for i in score {
                if record > i.score {
                    returnValue = true
                }
            }
        }
        return returnValue
    }
    
    // MARK: - Helper Methods
    
    private func delay(delay: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
    
    private func getMaxNum() -> Int {
        var temp: [Int] = []
        if let array = ResultsManager.savedResults() {
            for i in array {
                temp.append(i.score)
            }
        }
        guard let maxNum = temp.max() else { return 0 }
        return maxNum
    }
    
    private func tapOnPause() {
        let pausedTime: CFTimeInterval = view.layer.convertTime(CACurrentMediaTime(), from: nil)
        view.layer.speed = 0.0
        view.layer.timeOffset = pausedTime
        self.timerPutObject.invalidate()
        self.timerCheckIntersection.invalidate()
        self.pauseView.updateScore(score: self.game.currentScore)
        self.pauseView.isHidden.toggle()
    }
    
    private func tapOnResume() {
        let pausedTime: CFTimeInterval = view.layer.timeOffset
        view.layer.speed = 1.0
        view.layer.timeOffset = 0.0
        view.layer.beginTime = 0.0
        let timeSincePause: CFTimeInterval = view.layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        view.layer.beginTime = timeSincePause
        self.restartTimer()
        self.pauseView.isHidden.toggle()
    }
    
    private func saveResult() {
        let record = Result(score: self.game.currentScore)
        if checkRecord(record: self.game.currentScore) {
            ResultsManager.saveResult(result: record)
        } else {
            ResultsManager.saveResult(result: record)
        }
    }
    
    //MARK: - Layout
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraintsNavigationBar()
        setConstraintsPauseView()
        setConstraintsScoreLableView()
        setConstraintsScoreLable()
        setFrameStartTimer()
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
    
    private func setConstraintsScoreLable() {
        scoreLable.snp.makeConstraints { make in
            make.centerX.equalTo(scoreLableView)
        }
    }
    
    private func setConstraintsScoreLableView() {
        scoreLableView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(40)
            make.centerX.equalTo(view)
            make.top.equalTo(scoreLable).offset(-5)
            make.leading.equalTo(scoreLable).offset(-10)
            make.bottom.equalTo(scoreLable).offset(5)
            make.trailing.equalTo(scoreLable).offset(10)
        }
    }
    
    private func setFrameStartTimer() {
        startTimer.frame = view.bounds
    }
}

//MARK: - Extension

extension GameViewController: PauseViewDelegate, ResultViewDelegate {
    func continueButtonTapped() {
        self.coordinator?.stepBack()
        self.coordinator?.displayGameScreen()
    }
    
    func exitButtonTapped() {
        self.saveResult()
        self.coordinator?.stepBack()
    }
    
    func playButtonTap() {
        tapOnResume()
    }
    
    func exitButtonTap() {
        self.coordinator?.stepBack()
    }
}
