//
//  UIImageViewLoadImgeExtension.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/21.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

// 自己写的简单的异步图片加载，做完后升级使用了SDWebImage
extension UIImageView {
    
    func loadImage(_ urlString: String) {
        self.image = #imageLiteral(resourceName: "defaultImg")
        DispatchQueue.global().async {
            let data = NSData(contentsOf: URL(string: urlString)!)
            let image = UIImage(data: data! as Data)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
