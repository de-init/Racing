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
    
    override init(frame: CGRect) {
        imageView = UIImageView()
        image = UIImage()
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - SetupUI
    private func setupUI() {
        setupImageView()
    }
    
    private func setupImageView() {
        imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.contentMode = .scaleAspectFill
        image = UIImage(named: "Leaderboard")
        imageView.image = image
        addSubview(imageView)
    }
    // MARK: - Constraints
    override func layoutSubviews() {
        super.layoutSubviews()
        makeConstraintsImageView()
    }

    private func makeConstraintsImageView() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.bottom.equalTo(self)
            make.trailing.equalTo(self)
        }
    }
}
