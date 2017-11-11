//
//  FriendsCircleCell.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/10.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class FriendsCircleCell: UITableViewCell {
    @IBOutlet weak var iconImgView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imgView: UIView!
    
    @IBOutlet weak var imgViewHeightConstraint: NSLayoutConstraint!
    var model: FriendsMessage? {
        didSet {
            guard (model != nil) else {
                return
            }
            nameLabel.text = model!.messageName
            contentLabel.text = model!.messageContent
            iconImgView.image = UIImage(named: model!.messageIcon)
            
            let imgWidth = (kScreenWidth - 60*2 - 10*2)/3.0
            let num = (model!.messageImages.count + 2)/3
            imgViewHeightConstraint.constant = 10 + (imgWidth + 10)*CGFloat(num)
            for i  in 0...8 {
                let imgView: UIImageView = self.viewWithTag(210 + i) as! UIImageView
                if  model!.messageImages.count > i {
                    imgView.isHidden = false
                    let path  = Bundle.main.path(forResource: "gastronomy" + model!.messageImages[i], ofType: "jpg")
                    imgView.image = UIImage(contentsOfFile: path!)
                } else {
                    imgView.isHidden = true
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        imgView.layer.masksToBounds = true
          for i  in 0...8 {
            let imgView: UIImageView = self.viewWithTag(210 + i) as! UIImageView
            imgView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(showImage(tap:)))
            imgView.addGestureRecognizer(tap)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func showImage(tap: UITapGestureRecognizer) {
        let num = (tap.view?.tag)! - 210
        let showView = ShowPictureScrollView(images: [(model?.messageImages[num])!])
        showView.show()
    }
    
}
