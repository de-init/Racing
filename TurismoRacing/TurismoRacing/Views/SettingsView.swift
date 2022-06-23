//
//  SettingsView.swift
//  TurismoRacing
//
//  Created by S2 on 23.06.22.
//

import Foundation
import UIKit

protocol SettingsViewDelegate: AnyObject {
    
}

class SettingsView: UIView {
    
    weak var delegate: SettingsViewDelegate?
    private var imageViewScreen: UIImageView!
    private var imageScreen: UIImage!
    
    override init(frame: CGRect) {
        imageViewScreen = UIImageView()
        imageScreen = UIImage()
        
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
    }

    override func layoutSubviews() {
        imageViewScreen.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
        }
    }
}
