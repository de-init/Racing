//
//  CarModelCollectionViewCell.swift
//  TurismoRacing
//
//  Created by S2 on 27.07.22.
//

import UIKit

class CarModelCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "CarModelCollectionViewCell"
        let carModel: UIImageView = {
            let imageView = UIImageView()
            imageView.backgroundColor = .clear
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(carModel)
        carModel.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.bottom.equalTo(self)
            make.trailing.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
