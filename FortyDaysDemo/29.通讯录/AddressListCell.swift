//
//  AddressListCell.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/12/1.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class AddressListCell: UITableViewCell {
    @IBOutlet weak var headImgView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
