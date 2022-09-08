//
//  HomeView.swift
//  TurismoRacing
//
//  Created by S2 on 15.06.22.
//

import Foundation
import UIKit
import SnapKit

protocol MenuViewDelegate: AnyObject {
    func didTapPlayButton()
    func didTapSettingsButton()
    func didTapLeaderboardButton()
    func didTapInfoButton()
}

class HomeMenu: UIView {
    weak var delegate: MenuViewDelegate?
    private var onPlayButton: UIButton!
    private var onSettingsButton: UIButton!
    private var onLeaderboardButton: UIButton!
    private var onGarageButton: UIButton!
    private var onShopButton: UIButton!
    private var onInfoButton: UIButton!
    private var imageViewMainScreen: UIImageView!
    private var imageMainScreen: UIImage!
    private var stackViewRight: UIStackView!
    private var stackViewLeft: UIStackView!
    var bestScoreLable: UILabel!
    
    override init(frame: CGRect) {
        onPlayButton = UIButton()
        onSettingsButton = UIButton()
        onLeaderboardButton = UIButton()
        onGarageButton = UIButton()
        onShopButton = UIButton()
        onInfoButton = UIButton()
        imageViewMainScreen = UIImageView()
        imageMainScreen = UIImage()
        bestScoreLable = UILabel()
        stackViewRight = UIStackView()
        stackViewLeft = UIStackView()
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        makeImageViewMainScreen()
        makePlayButton()
        makeSettingsButton()
        makeLeaderboardButton()
        makeGarageButton()
        makeShopButton()
        makeInfoButton()
        makeBestScoreLable()
        makeStackViewRight()
        makeStackViewLeft()
    }
    private func makeImageViewMainScreen() {
        imageViewMainScreen = UIImageView(frame: UIScreen.main.bounds)
        imageViewMainScreen.contentMode = .scaleAspectFill
        imageMainScreen = UIImage(named: "Mainscreen")
        imageViewMainScreen.image = imageMainScreen
        addSubview(imageViewMainScreen)
    }
    private func makePlayButton() {
        onPlayButton = createButton(image: "ic_playButton")
        onPlayButton.setTitle(Strings.play.localized, for: .normal)
        onPlayButton.titleLabel?.font = UIFont(name: Fonts.OrelegaOne.regular.fontName, size: 27)
        onPlayButton.titleLabel?.textColor = .white
        onPlayButton.titleLabel?.adjustsFontSizeToFitWidth = true
        onPlayButton.addTarget(self, action: #selector(didTapPlayButton), for: .touchUpInside)
        addSubview(onPlayButton)
    }
    private func makeSettingsButton() {
        onSettingsButton = createButton(image: "ic_settingsButton")
        onSettingsButton.addTarget(self, action: #selector(didTapSettingsButton), for: .touchUpInside)
        addSubview(onSettingsButton)
    }
    private func makeLeaderboardButton() {
        onLeaderboardButton = createButton(image: "ic_leaderboardButton")
        onLeaderboardButton.addTarget(self, action: #selector(didTapLeaderboardButton), for: .touchUpInside)
        addSubview(onLeaderboardButton)
    }
    private func makeGarageButton() {
        onGarageButton = createButton(image: "ic_garageButton")
        addSubview(onGarageButton)
    }
    private func makeShopButton() {
        onShopButton = createButton(image: "ic_shopButton")
        addSubview(onShopButton)
    }
    private func makeInfoButton() {
        onInfoButton = createButton(image: "ic_infoButton")
        onInfoButton.addTarget(self, action: #selector(didTapInfoButton), for: .touchUpInside)
        addSubview(onInfoButton)
    }
    private func makeBestScoreLable() {
        bestScoreLable = UILabel()
        bestScoreLable.text = Strings.bestScore.localized
        bestScoreLable.textColor = .white
        bestScoreLable.font = UIFont(name: Fonts.Poppins.bold.fontName, size: 28)
        bestScoreLable.numberOfLines = 0
        bestScoreLable.textAlignment = .center
        bestScoreLable.adjustsFontSizeToFitWidth = true
        addSubview(bestScoreLable)
    }
    private func makeStackViewRight() {
        stackViewRight = UIStackView(arrangedSubviews: [onSettingsButton, onLeaderboardButton])
        stackViewRight.axis = .vertical
        stackViewRight.distribution = .fillEqually
        stackViewRight.alignment = .fill
        stackViewRight.spacing = 15
        addSubview(stackViewRight)
    }
    private func makeStackViewLeft() {
        stackViewLeft = UIStackView(arrangedSubviews: [onShopButton, onGarageButton])
        stackViewLeft.axis = .vertical
        stackViewLeft.distribution = .fillEqually
        stackViewLeft.alignment = .fill
        stackViewLeft.spacing = 15
        addSubview(stackViewLeft)
    }
    // MARK: - Additional Methods
    private func createButton(image: String) -> UIButton {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: image), for: .normal)
        button.setBackgroundImage(UIImage(named: image)?.withAlpha(0.8), for: .highlighted)
        button.layoutIfNeeded()
        button.subviews.first?.contentMode = .scaleAspectFit
        return button
    }
    // MARK: - Delegate Methods
    @objc private func didTapPlayButton() {
        delegate?.didTapPlayButton()
    }
    @objc private func didTapSettingsButton() {
        delegate?.didTapSettingsButton()
    }
    @objc private func didTapLeaderboardButton() {
        delegate?.didTapLeaderboardButton()
    }
    @objc private func didTapInfoButton() {
        delegate?.didTapInfoButton()
    }
    // MARK: - Layout
    override func layoutSubviews() {
        setupConstraints()
    }
    
    private func setupConstraints() {
        makeConstraintsImageViewMainScreen()
        makeConstraintsPlayButton()
        makeConstraintsInfoButton()
        makeConstraintsBestScoreLable()
        makeConstraintsStackViewRight()
        makeConstraintsStackViewLeft()
    }
    private func makeConstraintsImageViewMainScreen() {
        imageViewMainScreen.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
        }
    }
    private func makeConstraintsPlayButton() {
        onPlayButton.snp.makeConstraints { make in
            make.bottom.equalTo(onInfoButton).offset(-100)
            make.leading.equalTo(40)
            make.trailing.equalTo(-40)
        }
    }
    private func makeConstraintsInfoButton() {
        onInfoButton.snp.makeConstraints { make in
            make.height.equalTo(65)
            make.width.equalTo(65)
            make.leading.equalTo(10)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }
    private func makeConstraintsBestScoreLable() {
        bestScoreLable.snp.makeConstraints { make in
            make.centerX.equalTo(self.center)
            make.top.equalTo(100)
            make.leading.equalTo(105)
            make.trailing.equalTo(-105)
        }
    }
    private func makeConstraintsStackViewRight() {
        stackViewRight.snp.makeConstraints { make in
            make.height.equalTo(165)
            make.width.equalTo(75)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(-15)
            make.leading.equalTo(10)
        }
    }
    private func makeConstraintsStackViewLeft() {
        stackViewLeft.snp.makeConstraints { make in
            make.height.equalTo(165)
            make.width.equalTo(75)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(-15)
            make.trailing.equalTo(-10)
        }
    }
}
