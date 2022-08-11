//
//  LeaderboardView.swift
//  TurismoRacing
//
//  Created by S2 on 30.06.22.
//

import Foundation
import UIKit

class LeaderboardView: UIView {
    private var imageView: UIImageView!
    private var image: UIImage!
    private var lable: UILabel!
    
    override init(frame: CGRect) {
        imageView = UIImageView()
        image = UIImage()
        lable = UILabel()
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - SetupUI
    private func setupUI() {
        setupImageView()
        setupLable()
    }
    
    private func setupImageView() {
        imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.contentMode = .scaleAspectFill
        image = UIImage(named: "Leaderboard")
        imageView.image = image
        addSubview(imageView)
    }

    private func setupLable() {
        lable = UILabel()
        lable.text = Strings.leaderboard.localized
        lable.font = UIFont(name: Fonts.OrelegaOne.regular.fontName, size: 45)
        lable.adjustsFontSizeToFitWidth = true
        lable.textAlignment = .center
        lable.textColor = .white
        addSubview(lable)
    }
    // MARK: - Constraints
    override func layoutSubviews() {
        setupConstraints()
    }
    
    private func setupConstraints() {
        makeConstraintsImageView()
        makeConstraintsLable()
    }
    
    private func makeConstraintsImageView() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.bottom.equalTo(self)
            make.trailing.equalTo(self)
        }
    }
    
    private func makeConstraintsLable() {
        lable.snp.makeConstraints { make in
            make.top.equalTo(self).offset(100)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
    }

}
