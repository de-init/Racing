//
//  SettingsView.swift
//  TurismoRacing
//
//  Created by S2 on 23.06.22.
//

import Foundation
import UIKit
import SnapKit

protocol SettingsViewDelegate: AnyObject {
    func didEasyButtonTapped()
    func didMediumButtonTapped()
    func didHardButtonTapped()
}

class SettingsView: UIView {
    
    weak var delegate: SettingsViewDelegate?
    private var imageViewScreen: UIImageView!
    private var imageScreen: UIImage!
    private var difficultyLable: UILabel!
    private var easyModeButton: UIButton!
    private var mediumModeButton: UIButton!
    private var hardModeButton: UIButton!
    private var stackViewButtons: UIStackView!
    
    override init(frame: CGRect) {
        imageViewScreen = UIImageView()
        imageScreen = UIImage()
        difficultyLable = UILabel()
        easyModeButton = UIButton()
        mediumModeButton = UIButton()
        hardModeButton = UIButton()
        stackViewButtons = UIStackView()
        
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        imageViewScreen = UIImageView(frame: UIScreen.main.bounds)
        imageViewScreen.contentMode = .scaleAspectFill
        imageScreen = UIImage(named: "Settings")
        imageViewScreen.image = imageScreen
        addSubview(imageViewScreen)
        
        difficultyLable = UILabel()
        difficultyLable.text = "Difficulty"
        difficultyLable.textColor = .white
        difficultyLable.font = UIFont(name: "OrelegaOne-Regular", size: 35)
        addSubview(difficultyLable)
    
        easyModeButton = createButton(color: UIColor.init(hex: 0x56AC49), title: "Easy")
        easyModeButton.setBackgroundColor(red: 86, green: 172, blue: 73, alpha: 0.2, forState: .highlighted)
        easyModeButton.addTarget(self, action: #selector(easyButtonTapped), for: .touchUpInside)
        addSubview(easyModeButton)
        
        mediumModeButton = createButton(color: UIColor.init(hex: 0xFB981F) , title: "Medium")
        mediumModeButton.setBackgroundColor(red: 251, green: 152, blue: 31, alpha: 0.2, forState: .highlighted)
        mediumModeButton.addTarget(self, action: #selector(mediumButtonTapped), for: .touchUpInside)
        addSubview(mediumModeButton)
        
        hardModeButton = createButton(color: UIColor.init(hex: 0xDC3E3F), title: "Hard")
        hardModeButton.setBackgroundColor(red: 220, green: 62, blue: 62, alpha: 0.2, forState: .highlighted)
        hardModeButton.addTarget(self, action: #selector(hardButtonTapped), for: .touchUpInside)
        addSubview(hardModeButton)
        
        stackViewButtons = UIStackView(arrangedSubviews: [easyModeButton, mediumModeButton, hardModeButton])
        stackViewButtons.axis = .vertical
        stackViewButtons.distribution = .fillEqually
        stackViewButtons.alignment = .fill
        stackViewButtons.spacing = 30
        addSubview(stackViewButtons)
        
    }
    
    private func createButton(color: UIColor, title: String) -> UIButton {
        let attributedString = NSAttributedString(string: title,
                                                  attributes: [
                                                  NSAttributedString.Key.font : UIFont(name: "OrelegaOne-Regular", size: 30),
                                                  NSAttributedString.Key.foregroundColor : UIColor.init(hex: 0xFFFFFF)])
        let button = UIButton()
        button.backgroundColor = color
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }
    
    @objc private func easyButtonTapped() {
        delegate?.didEasyButtonTapped()
    }

    @objc private func mediumButtonTapped() {
        delegate?.didMediumButtonTapped()
    }

    @objc private func hardButtonTapped() {
        delegate?.didHardButtonTapped()
    }

    
    override func layoutSubviews() {
        imageViewScreen.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
        }
        difficultyLable.snp.makeConstraints { make in
            make.centerX.equalTo(self.center)
            make.centerY.equalTo(self.center)
        }
        stackViewButtons.snp.makeConstraints { make in
            make.top.equalTo(difficultyLable).offset(50)
            make.bottom.equalTo(self).offset(-30)
            make.leading.equalTo(90)
            make.trailing.equalTo(-90)
        }
    }
}

extension UIButton {
    func setBackgroundColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat, forState: UIControl.State) {
        self.clipsToBounds = true
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(red: red, green: green, blue: blue, alpha: alpha)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
