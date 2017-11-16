//
//  RecorderCell.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/16.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class RecorderCell: UITableViewCell {
    let recorderManager = RecorderManager()
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func playAction(_ sender: UIButton) {
        
        if !sender.isSelected {
            recorderManager.play(name: titleLabel.text!)
            
        } else {
            recorderManager.pausePlay()
        }
        sender.isSelected = !sender.isSelected

    }
    
    @IBAction func stopAction(_ sender: UIButton) {
        recorderManager.stopPlay()
    }
}
