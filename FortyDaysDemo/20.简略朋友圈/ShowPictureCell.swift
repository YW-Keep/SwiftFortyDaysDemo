//
//  ShowPictureCell.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/13.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class ShowPictureCell: UICollectionViewCell, UIScrollViewDelegate {
    
    lazy var scrollView: UIScrollView = {
        let  inScrollView  = UIScrollView(frame:CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        inScrollView.addSubview(imageView)
        inScrollView.delegate = self
        inScrollView.maximumZoomScale = 2.0
        inScrollView.minimumZoomScale = 1
        inScrollView.backgroundColor = .black
        inScrollView.showsVerticalScrollIndicator = false
        inScrollView.showsHorizontalScrollIndicator = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(changeSizeAction(tap:)))
        tap.numberOfTapsRequired = 2
        inScrollView.addGestureRecognizer(tap)
        return inScrollView
    }()
    
    lazy var imageView: UIImageView = {
        let inImgView =  UIImageView()
        return inImgView
    }()
    
    var image: UIImage? {
        didSet {
            let height = image!.size.height / image!.size.width * kScreenWidth
            imageView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: height)
            imageView.center = scrollView.center
            scrollView.contentSize = CGSize(width: kScreenWidth, height: max(kScreenHeight, height))
            imageView.image = image
        }
    }
    
    // 显示动画
    var startRect :CGRect? {
         didSet {
            if startRect != nil {
                
                let  rect  = imageView.frame
                imageView.frame = startRect!
                UIView.animate(withDuration: 0.5, animations: {
                    self.imageView.frame = rect
                })
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.addSubview(scrollView)
        self.isUserInteractionEnabled = true
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func changeSizeAction(tap: UITapGestureRecognizer) {
        // 计算点击放大区域
        let point = tap.location(in: self.scrollView)
        var xGap = point.x - kScreenWidth/2
        if  xGap > 0 {
            xGap = min(kScreenWidth/2, xGap * 2 )
        } else {
            xGap = max( -kScreenWidth/2, xGap * 2)
        }
        xGap = xGap + kScreenWidth / 2
        
        var yGap: CGFloat = 0
        let hightGap = (image!.size.height / image!.size.width * kScreenWidth * 2 - kScreenHeight)
        if hightGap > 0 {
            yGap = point.x - hightGap/2
            if  yGap > 0 {
                yGap = min(hightGap/2, yGap * 2 )
            } else {
                yGap = max( -hightGap/2, yGap * 2)
            }
            yGap = yGap + hightGap / 2
        }
   
        UIView.animate(withDuration: 0.5) {
            self.scrollView.zoomScale = self.scrollView.zoomScale > 1 ? 1 : 2
            self.scrollView.contentOffset =  self.scrollView.zoomScale > 1 ? CGPoint(x: xGap, y: yGap) : CGPoint(x: 0, y: 0)
        }
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
