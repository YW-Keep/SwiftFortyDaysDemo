//
//  ShowPictureScrollView.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/10.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class ShowPictureScrollView: UIScrollView, UIScrollViewDelegate {
    
    var imagesArray: [String]
    
    var imageView: UIImageView
    
  
    init(images: [String]) {
        imagesArray = images
        let path  = Bundle.main.path(forResource: "gastronomy" + imagesArray[0], ofType: "jpg")
        let image = UIImage(contentsOfFile: path!)
        var height = image!.size.height / image!.size.width * kScreenWidth
        var weight = image!.size.width / image!.size.height * kScreenHeight
        if height > kScreenHeight {
            height = kScreenHeight
        } else {
            weight = kScreenWidth
        }
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: weight, height: height))
        imageView.image = image
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        self.maximumZoomScale = 2.0
        self.minimumZoomScale = 1
        self.delegate = self
        self.isPagingEnabled = true
        self.contentSize = CGSize(width: kScreenWidth, height: kScreenHeight)
        self.backgroundColor = .black
        self.addSubview(imageView)
        imageView.center = self.center
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        UIApplication.shared.delegate?.window??.addSubview(self)
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        //        print(scrollView.zoomScale)
        // 居中显示
        let offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width) ? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
        let offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height) ?
            (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
        imageView.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX, y: scrollView.contentSize.height * 0.5 + offsetY)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
