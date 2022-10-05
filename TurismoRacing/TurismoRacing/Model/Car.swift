//
//  Car.swift
//  TurismoRacing
//
//  Created by S2 on 30.09.22.
//

import Foundation
import UIKit

class Car: UIImageView {
    var animator: UIViewPropertyAnimator!
    var carModel: String {
        let settings = UserDefaultsManager.shared.getSettings()
        let string = "\(Cars.carsArray[settings.car])"
        return string
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentMode = .scaleAspectFill
        self.image = UIImage(named: carModel)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
    }
    
    func movingCar(direction: CGFloat) {
        let step = self.frame.width
        animator = UIViewPropertyAnimator(duration: 0.05, curve: .linear, animations: { self.frame.origin.x += direction * step })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
