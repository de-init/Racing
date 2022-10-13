//
//  EndGameView.swift
//  TurismoRacing
//
//  Created by S2 on 11.10.22.
//

import Foundation
import UIKit

protocol ResultViewDelegate: AnyObject {
    func continueButtonTapped()
    func exitButtonTapped()
}

class ResultView: UIView {
    var totalScore: UILabel
    var recordScore: UILabel
    private var continueButton: UIButton
    private var exitButton: UIButton
    weak var delegate: ResultViewDelegate?
    
    override init(frame: CGRect) {
        totalScore = UILabel()
        recordScore = UILabel()
        continueButton = UIButton()
        exitButton = UIButton()
        super.init(frame: frame)
        setUI()
    }
    
    private func setUI() {
        setSelfView()
        setTotalScoreLable()
        setRecordScoreLable()
        setContinueButton()
        setExitButton()
    }
    
    private func setSelfView() {
        backgroundColor = .black.withAlphaComponent(0.2)
    }
    
    private func setTotalScoreLable() {
        totalScore = createLable(text: Strings.totalScore.localized)
        addSubview(totalScore)
    }
    
    private func setRecordScoreLable() {
        recordScore = createLable(text: Strings.recordScore.localized)
        addSubview(recordScore)
    }
    
    private func setContinueButton() {
        continueButton = createButton(title: Strings.play.localized, image: "continueButtonImage")
        continueButton.addTarget(self, action: #selector(continueButtonTap), for: .touchUpInside)
        addSubview(continueButton)
    }
    
    private func setExitButton() {
        exitButton = createButton(title: Strings.exitText.localized, image: "exitButtonImage")
        exitButton.addTarget(self, action: #selector(exitButtonTap), for: .touchUpInside)
        addSubview(exitButton)
    }
    
    private func createButton(title: String, image: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setBackgroundImage(UIImage(named: image), for: .normal)
        button.setBackgroundImage(UIImage(named: image)?.withAlpha(0.8), for: .highlighted)
        button.titleLabel?.font = UIFont(name: Fonts.OrelegaOne.regular.fontName, size: 28)
        button.titleLabel?.textColor = .white
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }
    private func createLable(text: String) -> UILabel {
        let lable = UILabel()
        lable.text = text
        lable.textColor = .white
        lable.font = UIFont(name: Fonts.Poppins.bold.fontName, size: 30)
        lable.adjustsFontSizeToFitWidth = true
        lable.textAlignment = .center
        lable.numberOfLines = 0
        return lable
    }
    
    @objc private func continueButtonTap() {
        delegate?.continueButtonTapped()
    }
    
    @objc private func exitButtonTap() {
        delegate?.exitButtonTapped()
    }
    
    override func layoutSubviews() {
        setupConstraints()
    }
    
    private func setupConstraints() {
        setConstraintsTotalScore()
        setConstraintsRecordScore()
        setConstraintsContinueButton()
        setConstraintsExitButton()
    }
    
    private func setConstraintsTotalScore() {
        totalScore.snp.makeConstraints { make in
            make.top.equalTo(self.recordScore).offset(-180)
            make.centerX.equalTo(self)
        }
    }
    
    private func setConstraintsRecordScore() {
        recordScore.snp.makeConstraints { make in
            make.top.equalTo(self.continueButton).offset(-180)
            make.centerX.equalTo(self)
        }
    }
    
    private func setConstraintsContinueButton() {
        continueButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.equalTo(self).offset(35)
            make.trailing.equalTo(self).inset(35)
            make.bottom.equalTo(self.exitButton).inset(70)
        }
    }
    
    private func setConstraintsExitButton() {
        exitButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalTo(self.continueButton).offset(40)
            make.trailing.equalTo(self.continueButton).inset(40)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(70)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
