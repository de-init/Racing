//
//  CustomNavigationBar.swift
//  TurismoRacing
//
//  Created by S2 on 19.09.22.
//

import Foundation
import UIKit
import SnapKit

class CustomNavigationBar: UIView {
    
    private let titleLabel = UILabel()
    private var titleText = String()
    private let leftButton = UIButton()
    private let rightButton = UIButton()
    private var leftItem: CustomNavigationBarItem!
    private var rightItem: CustomNavigationBarItem!
    
    init(leftItem: CustomNavigationBarItem?, rightItem: CustomNavigationBarItem?, titleText: String) {
        self.leftItem = leftItem
        self.rightItem = rightItem
        self.titleText = titleText
        super.init(frame: .zero)
        setupNavigationBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNavigationBar() {
        setupLeftButton()
        setupRightButton()
        setupTitleLable()
    }
    
    private func setupLeftButton() {
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.setBackgroundImage(UIImage(named: leftItem.imageName), for: .normal)
        leftButton.setBackgroundImage(UIImage(named: leftItem.imageName)?.withAlpha(0.8), for: .highlighted)
        leftButton.addTarget(self, action: #selector(onLeftButtonTapped), for: .touchUpInside)
        addSubview(leftButton)
    }
    
    private func setupRightButton() {
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.setBackgroundImage(UIImage(named: rightItem.imageName), for: .normal)
        rightButton.setBackgroundImage(UIImage(named: rightItem.imageName)?.withAlpha(0.8), for: .highlighted)
        rightButton.addTarget(self, action: #selector(onRightButtonTapped), for: .touchUpInside)
        addSubview(rightButton)
    }
    
    private func setupTitleLable() {
        titleLabel.text = titleText
        titleLabel.textColor = .white
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont(name: Fonts.OrelegaOne.regular.fontName, size: 35)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
    }

    @objc private func onLeftButtonTapped() {
        if let leftItem = leftItem {
            leftItem.itemAction()
        }
    }
    
    @objc private func onRightButtonTapped() {
        if let rightItem = rightItem {
            rightItem.itemAction()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeConstraintsLeftButton()
        makeConstraintsRightButton()
        makeConstraintsTitleLable()
    }
    
    private func makeConstraintsLeftButton() {
        leftButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(60)
            make.top.equalTo(self)
            make.leading.equalTo(self).offset(10)
        }
    }
    
    private func makeConstraintsRightButton() {
        rightButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(60)
            make.top.equalTo(self)
            make.trailing.equalTo(self).inset(10)
        }
    }

    private func makeConstraintsTitleLable() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
            make.leading.equalTo(leftButton).offset(65)
            make.trailing.equalTo(rightButton).inset(65)
        }
    }
}
