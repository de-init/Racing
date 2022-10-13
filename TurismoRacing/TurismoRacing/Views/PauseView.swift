//
//  PauseView.swift
//  TurismoRacing
//
//  Created by S2 on 14.09.22.
//

import UIKit
import SnapKit

protocol PauseViewDelegate: AnyObject {
    func playButtonTap()
    func exitButtonTap()
}

class PauseView: UIView {
    
    private let textLable: UILabel
    private let playButton: UIButton
    private let exitButton: UIButton
    private var stackButtons: UIStackView
    weak var delegate: PauseViewDelegate?

    override init(frame: CGRect) {
        textLable = UILabel()
        playButton = UIButton()
        exitButton = UIButton()
        stackButtons = UIStackView()
        
        super.init(frame: frame)
        setupUI()
    }
    //MARK: - UI

    private func setupUI() {
        setupPauseView()
        setupTextLable()
        setupPlayButton()
        setupExitButton()
        setupStackButtons()
    }
    
    private func setupPauseView() {
        self.backgroundColor = UIColor(hex: 0xFF9B71)
        self.layer.borderWidth = 12
        self.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 0.44)
        self.layer.cornerRadius = 50
        self.clipsToBounds = true
        self.isHidden = true
    }
    
    private func setupTextLable() {
        textLable.text = Strings.pauseText.localized
        textLable.font = UIFont(name: Fonts.OrelegaOne.regular.fontName, size: 38)
        textLable.numberOfLines = 0
        textLable.textAlignment = .center
        textLable.textColor = .white
        addSubview(textLable)
    }
    
    func updateScore(score: Int) {
        self.textLable.text = Strings.pauseText.localized + "\n \(score)"
    }

    private func setupPlayButton() {
        playButton.backgroundColor = UIColor(hex: 0x4C86A8)
        playButton.setTitle("\(Strings.playText.localized)", for: .normal)
        playButton.titleLabel?.font = UIFont(name: Fonts.OrelegaOne.regular.fontName, size: 22)
        playButton.layer.borderWidth = 6
        playButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 0.7)
        playButton.layer.cornerRadius = 30
        playButton.clipsToBounds = true
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
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
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
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
    
    //MARK: - Delegate
    
    @objc func playButtonTapped() {
        delegate?.playButtonTap()
    }
    
    @objc func exitButtonTapped() {
        delegate?.exitButtonTap()
    }
    
    //MARK: - Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    private func setupConstraints() {
        setupConstraintsTextLable()
        setupConstraintsStackButtons()
    }
    
    private func setupConstraintsTextLable() {
        textLable.snp.makeConstraints { make in
            make.top.equalTo(self).offset(30)
            make.leading.equalTo(self).offset(30)
            make.trailing.equalTo(self).inset(30)
        }
    }
    
    private func setupConstraintsStackButtons() {
        stackButtons.snp.makeConstraints { make in
            make.top.equalTo(textLable).offset(135)
            make.bottom.equalTo(self).inset(40)
            make.leading.equalTo(self).offset(40)
            make.trailing.equalTo(self).inset(40)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
