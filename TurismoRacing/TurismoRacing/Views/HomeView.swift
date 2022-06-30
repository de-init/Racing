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
}

class HomeMenu: UIView {
    
    weak var delegate: MenuViewDelegate?
    private var labelPlayText: UILabel!
    private var onPlayButton: UIButton!
    private var onSettingsButton: UIButton!
    private var onLeaderboardButton: UIButton!
    private var onGarageButton: UIButton!
    private var onShopButton: UIButton!
    private var imageViewMainScreen: UIImageView!
    private var imageMainScreen: UIImage!
    var bestScoreLable: UILabel!
    
    override init(frame: CGRect) {
        labelPlayText = UILabel()
        onPlayButton = UIButton()
        onSettingsButton = UIButton()
        onLeaderboardButton = UIButton()
        onGarageButton = UIButton()
        onShopButton = UIButton()
        imageViewMainScreen = UIImageView()
        imageMainScreen = UIImage()
        bestScoreLable = UILabel()
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - UI
    // MARK: -
    private func setupUI() {
        imageViewMainScreen = UIImageView(frame: UIScreen.main.bounds)
        imageViewMainScreen.contentMode = .scaleAspectFill
        imageMainScreen = UIImage(named: "Mainscreen")
        imageViewMainScreen.image = imageMainScreen
        addSubview(imageViewMainScreen)
        
        
        onPlayButton = createButton(image: "ic_playButton", clickedImage: "ic_playButtonClicked")
        onPlayButton.addTarget(self, action: #selector(didTapPlayButton), for: .touchUpInside)
        addSubview(onPlayButton)
        
        labelPlayText.text = "PLAY"
        labelPlayText.textColor = .white
        labelPlayText.font = UIFont(name: "OrelegaOne-Regular", size: 25)
        labelPlayText.adjustsFontForContentSizeCategory = true
        onPlayButton.addSubview(labelPlayText)
        
        onSettingsButton = createButton(image: "ic_settingsButton", clickedImage: "ic_settingsButtonClicked")
        onSettingsButton.addTarget(self, action: #selector(didTapSettingsButton), for: .touchUpInside)
        addSubview(onSettingsButton)
        
        onLeaderboardButton = createButton(image: "ic_leaderboardButton", clickedImage: "ic_leaderboardButtonClicked")
        onLeaderboardButton.addTarget(self, action: #selector(didTapLeaderboardButton), for: .touchUpInside)
        addSubview(onLeaderboardButton)
        
        onGarageButton = createButton(image: "ic_garageButton", clickedImage: "ic_garageButtonClicked")
        addSubview(onGarageButton)
        
        onShopButton = createButton(image: "ic_shopButton", clickedImage: "ic_shopButtonClicked")
        addSubview(onShopButton)

        bestScoreLable = UILabel()
        bestScoreLable.text = "Best Score"
        bestScoreLable.textColor = .white
        bestScoreLable.font = UIFont(name: "Poppins-Bold", size: 28)
        bestScoreLable.numberOfLines = 0
        bestScoreLable.textAlignment = .center
        addSubview(bestScoreLable)
    }
    
    private func createButton(image: String, clickedImage: String) -> UIButton {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: image), for: .normal)
        button.setBackgroundImage(UIImage(named: clickedImage), for: .highlighted)
        button.layoutIfNeeded()
        button.subviews.first?.contentMode = .scaleAspectFit
        return button
    }
    
    @objc private func didTapPlayButton() {
        delegate?.didTapPlayButton()
    }
    
    @objc private func didTapSettingsButton() {
        delegate?.didTapSettingsButton()
    }
    
    @objc private func didTapLeaderboardButton() {
        delegate?.didTapLeaderboardButton()
    }

    
    // MARK: - Layout
    // MARK: -
    
    override func layoutSubviews() {
        imageViewMainScreen.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
        }
        onPlayButton.snp.makeConstraints { make in
            make.top.equalTo(540)
            make.bottom.equalTo(-30)
            make.leading.equalTo(40)
            make.trailing.equalTo(-40)
        }
        labelPlayText.snp.makeConstraints { make in
            make.centerX.equalTo(onPlayButton)
            make.centerY.equalTo(onPlayButton)
        }
        onSettingsButton.snp.makeConstraints { make in
            make.top.equalTo(80)
            make.leading.equalTo(10)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        onLeaderboardButton.snp.makeConstraints { make in
            make.top.equalTo(80)
            make.trailing.equalTo(-10)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        onShopButton.snp.makeConstraints { make in
            make.top.equalTo(onSettingsButton).offset(95)
            make.leading.equalTo(10)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        onGarageButton.snp.makeConstraints { make in
            make.top.equalTo(onLeaderboardButton).offset(95)
            make.trailing.equalTo(-10)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        bestScoreLable.snp.makeConstraints { make in
            make.centerX.equalTo(self.center)
            make.top.equalTo(100)
        }
    }
}
