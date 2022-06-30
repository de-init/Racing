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
    
    private func setupUI() {
        imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.contentMode = .scaleAspectFill
        image = UIImage(named: "Leaderboard")
        imageView.image = image
        addSubview(imageView)
        
        lable = UILabel()
        lable.text = "Leaderboard"
        lable.font = UIFont(name: "OrelegaOne-Regular", size: 45)
        lable.textAlignment = .center
        lable.textColor = .white
        addSubview(lable)
        
    }
    
    override func layoutSubviews() {
        lable.snp.makeConstraints { make in
            make.top.equalTo(self).offset(100)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
    }
}
