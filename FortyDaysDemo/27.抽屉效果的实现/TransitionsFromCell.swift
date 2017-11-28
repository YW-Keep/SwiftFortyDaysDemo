//
//  TransitionsFromCell.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/28.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class TransitionsFromCell: UITableViewCell {
    let showImageView: UIImageView
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        showImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 200))
        showImageView.contentMode = .scaleAspectFill
        showImageView.layer.masksToBounds = true
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(showImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
