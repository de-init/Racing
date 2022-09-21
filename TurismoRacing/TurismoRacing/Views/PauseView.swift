//
//  PauseView.swift
//  TurismoRacing
//
//  Created by S2 on 14.09.22.
//

import UIKit
import SnapKit

class PauseView: UIView {
    
    private let pauseView: UIView
    private let textLable: UILabel
    private let playButton: UIButton
    private let exitButton: UIButton
    private var stackButtons: UIStackView
    private var score = 0

    override init(frame: CGRect) {
        pauseView = UIView()
        textLable = UILabel()
        playButton = UIButton()
        exitButton = UIButton()
        stackButtons = UIStackView()
        
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        setupPauseView()
        setupTextLable()
        setupPlayButton()
        setupExitButton()
        setupStackButtons()
    }
    
    private func setupPauseView() {
        pauseView.backgroundColor = UIColor(hex: 0xFF9B71)
        pauseView.layer.borderWidth = 12
        pauseView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 0.44)
        pauseView.layer.cornerRadius = 50
        pauseView.clipsToBounds = true
        addSubview(pauseView)
    }
    
    private func setupTextLable() {
        textLable.text = "\(Strings.pauseText.localized) \n \(score)"
        textLable.font = UIFont(name: Fonts.OrelegaOne.regular.fontName, size: 38)
        textLable.numberOfLines = 0
        textLable.textAlignment = .center
        textLable.textColor = .white
        addSubview(textLable)
    }

    private func setupPlayButton() {
        playButton.backgroundColor = UIColor(hex: 0x4C86A8)
        playButton.setTitle("\(Strings.playText.localized)", for: .normal)
        playButton.titleLabel?.font = UIFont(name: Fonts.OrelegaOne.regular.fontName, size: 22)
        playButton.layer.borderWidth = 6
        playButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 0.7)
        playButton.layer.cornerRadius = 30
        playButton.clipsToBounds = true
        addSubview(playButton)
    }

    private func setupExitButton() {
        exitButton.backgroundColor = UIColor(hex: 0xE0777D)
        exitButton.setTitle("\(Strings.exitText.localized)", for: .normal)
        exitButton.titleLabel?.font = UIFont(name: Fonts.OrelegaOne.regular.fontName, size: 22)
        exitButton.layer.borderWidth = 6
        exitButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 0.7)
        exitButton.layer.cornerRadius = 30
        exitButton.clipsToBounds = true
        addSubview(exitButton)
    }
    
    private func setupStackButtons() {
        stackButtons = UIStackView(arrangedSubviews: [playButton, exitButton])
        stackButtons.axis = .vertical
        stackButtons.distribution = .fillEqually
        stackButtons.alignment = .fill
        stackButtons.spacing = 15
        addSubview(stackButtons)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    private func setupConstraints() {
        setupConstraintsPauseView()
        setupConstraintsTextLable()
        setupConstraintsStackButtons()
    }
    
    private func setupConstraintsPauseView() {
        pauseView.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(350)
            make.centerX.equalTo(self.center)
            make.centerY.equalTo(self.center)
        }
    }
    
    private func setupConstraintsTextLable() {
        textLable.snp.makeConstraints { make in
            make.top.equalTo(pauseView).offset(30)
            make.leading.equalTo(pauseView).offset(30)
            make.trailing.equalTo(pauseView).inset(30)
        }
    }
    
    private func setupConstraintsStackButtons() {
        stackButtons.snp.makeConstraints { make in
            make.top.equalTo(textLable).offset(135)
            make.bottom.equalTo(pauseView).inset(40)
            make.leading.equalTo(pauseView).offset(40)
            make.trailing.equalTo(pauseView).inset(40)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
