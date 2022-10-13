//
//  StartTimer.swift
//  TurismoRacing
//
//  Created by S2 on 27.09.22.
//

import Foundation
import UIKit
import SnapKit

class StartTimer: UIView {
    private var startTimerLable = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStartTimerLable()
    }
    
    private func setupStartTimerLable() {
        startTimerLable.text = "3"
        startTimerLable.font = UIFont.boldSystemFont(ofSize: 85)
        startTimerLable.textColor = UIColor.init(hex: 0xD9F339)
        startTimerLable.numberOfLines = 0
        startTimerLable.textAlignment = .center
        addSubview(startTimerLable)
    }
    
    func animateStart() {
        UIView.animate(withDuration: 1, delay: 0) {
            self.startTimerLable.transform = CGAffineTransform(scaleX: 2, y: 2)
            self.startTimerLable.layer.opacity = 0.2
        } completion: { _ in
            self.startTimerLable.transform = .identity
            self.startTimerLable.text = "2"
            self.startTimerLable.layer.opacity = 1
            UIView.animate(withDuration: 1, delay: 0) {
                self.startTimerLable.transform = CGAffineTransform(scaleX: 2, y: 2)
                self.startTimerLable.layer.opacity = 0.2
            } completion: { _ in
                self.startTimerLable.transform = .identity
                self.startTimerLable.text = "1"
                self.startTimerLable.layer.opacity = 1
                UIView.animate(withDuration: 1, delay: 0) {
                    self.startTimerLable.transform = CGAffineTransform(scaleX: 2, y: 2)
                    self.startTimerLable.layer.opacity = 0.2
                } completion: { _ in
                    self.startTimerLable.transform = .identity
                    self.startTimerLable.layer.opacity = 1
                    self.startTimerLable.text = "GOOO!"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.startTimerLable.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        startTimerLable.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
