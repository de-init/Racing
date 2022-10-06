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
    private var imageViewScreen: UIImageView!
    private var imageScreen: UIImage!
    private let difficultyLable: UILabel
    private var easyModeButton: UIButton!
    private var mediumModeButton: UIButton!
    private var hardModeButton: UIButton!
    private var stackViewButtons: UIStackView!
    private let selectedRectangle: UIImageView
    private let carModelCollectionView = CarModelCollectionView()
    weak var delegate: SettingsViewDelegate?
    
    override init(frame: CGRect) {
        imageViewScreen = UIImageView()
        imageScreen = UIImage()
        difficultyLable = UILabel()
        easyModeButton = UIButton()
        mediumModeButton = UIButton()
        hardModeButton = UIButton()
        stackViewButtons = UIStackView()
        selectedRectangle = UIImageView()
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupUI
    
    private func setupUI() {
        makeImageViewScreen()
        makeDifficultyLable()
        makeEasyModeButton()
        makeMediumModeButton()
        makeHardModeButton()
        makeStackViewButtons()
        addCarModelCollectionView()
        makeSelectionRectangle()
    }
    
    private func makeImageViewScreen() {
        imageViewScreen = UIImageView(frame: UIScreen.main.bounds)
        imageViewScreen.contentMode = .scaleAspectFill
        imageScreen = UIImage(named: "Settings")
        imageViewScreen.image = imageScreen
        addSubview(imageViewScreen)
    }
    
    private func makeDifficultyLable() {
        difficultyLable.text = Strings.difficulty.localized
        difficultyLable.textColor = .white
        difficultyLable.textAlignment = .center
        difficultyLable.font = UIFont(name: Fonts.OrelegaOne.regular.fontName, size: 35)
        difficultyLable.adjustsFontSizeToFitWidth = true
        addSubview(difficultyLable)
    }
    
    private func makeEasyModeButton() {
        easyModeButton = createButton(color: UIColor.init(hex: 0x56AC49), title: Strings.easy.localized)
        easyModeButton.setBackgroundColor(red: 86, green: 172, blue: 73, alpha: 0.2, forState: .highlighted)
        easyModeButton.addTarget(self, action: #selector(easyButtonTapped), for: .touchUpInside)
        addSubview(easyModeButton)
    }
    
    private func makeMediumModeButton() {
        mediumModeButton = createButton(color: UIColor.init(hex: 0xFB981F) , title: Strings.medium.localized)
        mediumModeButton.setBackgroundColor(red: 251, green: 152, blue: 31, alpha: 0.2, forState: .highlighted)
        mediumModeButton.addTarget(self, action: #selector(mediumButtonTapped), for: .touchUpInside)
        addSubview(mediumModeButton)
    }
    
    private func makeHardModeButton() {
        hardModeButton = createButton(color: UIColor.init(hex: 0xDC3E3F), title: Strings.hard.localized)
        hardModeButton.setBackgroundColor(red: 220, green: 62, blue: 62, alpha: 0.2, forState: .highlighted)
        hardModeButton.addTarget(self, action: #selector(hardButtonTapped), for: .touchUpInside)
        addSubview(hardModeButton)
    }
    
    private func makeStackViewButtons() {
        stackViewButtons = UIStackView(arrangedSubviews: [difficultyLable, easyModeButton, mediumModeButton, hardModeButton])
        stackViewButtons.axis = .vertical
        stackViewButtons.distribution = .fillEqually
        stackViewButtons.alignment = .fill
        stackViewButtons.spacing = 25
        addSubview(stackViewButtons)
    }
    
    private func makeSelectionRectangle() {
        selectedRectangle.image = UIImage(named: "selectedRectangleImage")
        addSubview(selectedRectangle)
        animateSelection()
    }
    
    private func addCarModelCollectionView() {
        addSubview(carModelCollectionView)
    }
    
    // MARK: - Additional Methods
    private func animateSelection() {
        let settings = UserDefaultsManager.shared.getSettings()
        switch settings.difficulty {
        case .normal:
            self.selectedRectangle.snp.remakeConstraints { make in
                make.top.equalTo(self.easyModeButton).offset(5)
                make.leading.equalTo(self.easyModeButton).offset(5)
                make.bottom.equalTo(self.easyModeButton).inset(5)
                make.trailing.equalTo(self.easyModeButton).inset(5)
            }
        case .medium:
            self.selectedRectangle.snp.remakeConstraints { make in
                make.top.equalTo(self.mediumModeButton).offset(5)
                make.leading.equalTo(self.mediumModeButton).offset(5)
                make.bottom.equalTo(self.mediumModeButton).inset(5)
                make.trailing.equalTo(self.mediumModeButton).inset(5)
            }
        case .hard:
            self.selectedRectangle.snp.remakeConstraints { make in
                make.top.equalTo(self.hardModeButton).offset(5)
                make.leading.equalTo(self.hardModeButton).offset(5)
                make.bottom.equalTo(self.hardModeButton).inset(5)
                make.trailing.equalTo(self.hardModeButton).inset(5)
            }
        }
    }
    
    private func createButton(color: UIColor, title: String) -> UIButton {
        let attributedString = NSAttributedString(string: title,
                                                  attributes: [
                                                    NSAttributedString.Key.font : UIFont(name: Fonts.OrelegaOne.regular.fontName, size: 30),
                                                    NSAttributedString.Key.foregroundColor : UIColor.init(hex: 0xFFFFFF)])
        let button = UIButton()
        button.backgroundColor = color
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }
    
    // MARK: - Delegate Methods
    
    @objc private func easyButtonTapped() {
        delegate?.didEasyButtonTapped()
        animateSelection()
    }
    
    @objc private func mediumButtonTapped() {
        delegate?.didMediumButtonTapped()
        animateSelection()
    }
    
    @objc private func hardButtonTapped() {
        delegate?.didHardButtonTapped()
        animateSelection()
    }
    
    // MARK: - Constraints
    
    override func layoutSubviews() {
        setupConstraints()
    }
    
    private func setupConstraints() {
        makeConstraintsImageViewScreen()
        makeConstraintsStackViewButtons()
        makeConstraintsCarModelCollectionView()
    }
    
    private func makeConstraintsImageViewScreen() {
        imageViewScreen.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
        }
    }
    
    private func makeConstraintsStackViewButtons() {
        stackViewButtons.snp.makeConstraints { make in
            make.top.equalTo(carModelCollectionView).offset(200)
            make.bottom.equalTo(-30)
            make.leading.equalTo(90)
            make.trailing.equalTo(-90)
        }
    }
    
    private func makeConstraintsCarModelCollectionView() {
        carModelCollectionView.snp.makeConstraints { make in
            make.height.equalTo(170)
            make.width.equalTo(bounds.width)
            make.top.equalTo(160)
        }
    }
}
