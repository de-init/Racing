//
//  GameView.swift
//  TurismoRacing
//
//  Created by S2 on 27.09.22.
//

import Foundation
import UIKit
import SnapKit

class GameView: UIView {
    private var scoreLable = UILabel()
    private let startTimer = StartTimer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        setupScoreLable()
        setupStartTimer()
    }
    
    private func setupStartTimer() {
        addSubview(startTimer)
    }

    private func setupScoreLable() {
        let color = CGColor(red: 0, green: 0, blue: 0, alpha: 0.37)
        let strokeTextAttributes = [
            NSAttributedString.Key.strokeColor : UIColor.init(hex: 0xE8E5DA),
            NSAttributedString.Key.foregroundColor : UIColor.init(hex: 0x648DE5),
            NSAttributedString.Key.strokeWidth : -3.0,
            NSAttributedString.Key.font : UIFont(name: Fonts.HammersmithOne.regular.fontName, size: 35) ?? UIFont.systemFont(ofSize: 35)]
        as [NSAttributedString.Key : Any]
        scoreLable = UILabel()
        scoreLable.adjustsFontSizeToFitWidth = true
        scoreLable.numberOfLines = 0
        scoreLable.layer.backgroundColor = color
        scoreLable.layer.cornerRadius = 15
        scoreLable.attributedText = NSMutableAttributedString(string: "\(Strings.score.localized)", attributes: strokeTextAttributes)
        addSubview(scoreLable)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        makeConstraintsScoreLable()
        makeConstraintsStartTimer()
    }

    private func makeConstraintsScoreLable() {
        scoreLable.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(40)
        }
    }
    private func makeConstraintsStartTimer() {
        startTimer.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
