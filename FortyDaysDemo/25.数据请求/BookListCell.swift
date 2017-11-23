//
//  BookListCell.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/21.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit
import SDWebImage

class BookListCell: UITableViewCell {
    @IBOutlet weak var bookImgView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    var model: BookListModel? {
        didSet {
            if model != nil {
                bookNameLabel.text = model!.bookName
                
                var names = ""
                for name in model!.author {
                    if names.count == 0 {
                        names = name
                    } else {
                        names = names + "," + name
                    }
                }
                authorLabel.text = names
                bookImgView?.loadImage(model!.bookImg)
                bookImgView.sd_setImage(with: URL(string: model!.bookImg), placeholderImage: UIImage(named: "defaultImg"))
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bookImgView?.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
