//
//  SearchTableViewCell.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/8.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var data: (image: String, title: String, content: String)? {
        didSet {
            let path  = Bundle.main.path(forResource: data?.image, ofType: "jpg")
            self.imgView?.image = UIImage.init(contentsOfFile: path!)
            self.titleLabel.text = data?.title
            self.contentLabel.text = data?.content
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
