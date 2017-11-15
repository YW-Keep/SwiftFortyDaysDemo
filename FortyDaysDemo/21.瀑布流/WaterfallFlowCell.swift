//
//  WaterfallFlowCell.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/15.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class WaterfallFlowCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        // 这么写有个大坑  浪费了我很久！ 因为这里在创建的时候固定了imageView的大小 导致在cell 复用的时候图片大小没变  
        let imgView =  UIImageView(frame: CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
