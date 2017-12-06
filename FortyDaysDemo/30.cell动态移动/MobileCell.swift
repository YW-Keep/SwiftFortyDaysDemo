//
//  MobileCell.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/12/6.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class MobileCell: UICollectionViewCell {
    var titleLabel: UILabel
    
    override init(frame: CGRect) {
        // 添加Label
        titleLabel = UILabel(frame:CGRect.init(x: 0, y: 0, width: 80, height: 30))
        super.init(frame: frame)
        self.titleLabel.numberOfLines = 0
        self.titleLabel.font = .systemFont(ofSize: 15)
        self.titleLabel.textColor = .white
        self.titleLabel.textAlignment = .center
        self.addSubview(self.titleLabel)
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        self.backgroundColor = .lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
