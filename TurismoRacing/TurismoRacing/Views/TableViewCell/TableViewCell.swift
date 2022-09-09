//
//  TableViewCell.swift
//  TurismoRacing
//
//  Created by S2 on 9.09.22.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    
    let countLable: UILabel
    let scoreLable: UILabel
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        countLable = UILabel()
        scoreLable = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupUI() {
        countLable.textColor = .white
        countLable.numberOfLines = 0
        countLable.adjustsFontSizeToFitWidth = true
        countLable.translatesAutoresizingMaskIntoConstraints = false
        countLable.font = UIFont(name: Fonts.Poppins.semiBold.fontName, size: 45)
        contentView.addSubview(countLable)
        
        scoreLable.textColor = .white
        scoreLable.font = UIFont(name: Fonts.Poppins.semiBold.fontName, size: 35)
        scoreLable.numberOfLines = 0
        scoreLable.adjustsFontSizeToFitWidth = true
        contentView.addSubview(scoreLable)
    }
    
    override func layoutSubviews() {
        countLable.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.leading.equalTo(contentView).offset(15)
            make.bottom.equalTo(contentView).offset(-10)
        }
        scoreLable.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.centerY.equalTo(contentView)
        }
    }
}
