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
    private var selectedButton: UIImageView!
    private let carModelCollectionView = CarModelCollectionView()
    
    override init(frame: CGRect) {
        imageViewScreen = UIImageView()
        imageScreen = UIImage()
        difficultyLable = UILabel()
        easyModeButton = UIButton()
        mediumModeButton = UIButton()
        hardModeButton = UIButton()
        stackViewButtons = UIStackView()
        selectedButton = UIImageView()
        
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
        difficultyLable.textAlignment = .center
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
        
        stackViewButtons = UIStackView(arrangedSubviews: [difficultyLable, easyModeButton, mediumModeButton, hardModeButton])
        stackViewButtons.axis = .vertical
        stackViewButtons.distribution = .fillEqually
        stackViewButtons.alignment = .fill
        stackViewButtons.spacing = 20
        addSubview(stackViewButtons)
        
        selectedButton = UIImageView()
        selectedButton.image = UIImage(named: "ic_selectedButton")
        addSubview(selectedButton)
        addSubview(carModelCollectionView)
    }
    
    func animateSelection() {
        if UserDefaults.standard.bool(forKey: "Easy") {
            selectedButton.snp.removeConstraints()
            UIView.animate(withDuration: 0.5, delay: 0) {
                self.selectedButton.snp.makeConstraints { make in
                    make.top.equalTo(self.easyModeButton).offset(5)
                    make.leading.equalTo(self.easyModeButton).offset(5)
                    make.bottom.equalTo(self.easyModeButton).offset(-5)
                    make.trailing.equalTo(self.easyModeButton).offset(-5)
                } 
            }
        } else if UserDefaults.standard.bool(forKey: "Medium") {
            selectedButton.snp.removeConstraints()
            UIView.animate(withDuration: 0.5, delay: 0) {
                self.selectedButton.snp.remakeConstraints { make in
                    make.top.equalTo(self.mediumModeButton).offset(5)
                    make.leading.equalTo(self.mediumModeButton).offset(5)
                    make.bottom.equalTo(self.mediumModeButton).offset(-5)
                    make.trailing.equalTo(self.mediumModeButton).offset(-5)
                }
            }
        } else if UserDefaults.standard.bool(forKey: "Hard") {
            selectedButton.snp.removeConstraints()
            UIView.animate(withDuration: 0.5, delay: 0) {
                self.selectedButton.snp.makeConstraints { make in
                    make.top.equalTo(self.hardModeButton).offset(5)
                    make.leading.equalTo(self.hardModeButton).offset(5)
                    make.bottom.equalTo(self.hardModeButton).offset(-5)
                    make.trailing.equalTo(self.hardModeButton).offset(-5)
                }
            }
        }
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
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
        }
        stackViewButtons.snp.makeConstraints { make in
            make.top.equalTo(carModelCollectionView).offset(250)
            make.bottom.equalTo(-30)
            make.leading.equalTo(90)
            make.trailing.equalTo(-90)
        }
        carModelCollectionView.snp.makeConstraints { make in
            make.height.equalTo(170)
            make.width.equalTo(bounds.width)
            make.top.equalTo(100)
        }
        animateSelection()
    }
}
