
//
//  ShowPictureView.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/13.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class ShowPictureView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate {
    let imagesArray: [String]
    private let pageNum: Int
    private let startRect: CGRect
    private var isFristShow = true
    private  lazy var tap: UITapGestureRecognizer = {
        // 设置点击消失
        let inTap = UITapGestureRecognizer(target: self, action: #selector(hidden))
        inTap.delegate = self
        return inTap
    }()
    init(images: [String], pageNum : Int, startRect: CGRect) {
        self.imagesArray = images
        self.pageNum = pageNum
        self.startRect = startRect
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.itemSize =  CGSize.init(width: kScreenWidth, height:kScreenHeight)
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 10)
        layout.minimumLineSpacing = 10
        // 这里有一种很完美的取巧实现滑动间距的方式，把滑动视图做的比显示大一些，这样分页的时候就会多分页一点这样就可以用系统的方式实现分页间距的变换了 是不是很简单 啊哈哈
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth + 10, height: kScreenHeight), collectionViewLayout: layout)
        self.register(ShowPictureCell.self, forCellWithReuseIdentifier: "ShowPictureCell")
        self.backgroundColor = .black
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.dataSource = self
        self.delegate = self
        self.isPagingEnabled = true
        
        // 设置起始位置
        self.contentOffset.x = CGFloat(pageNum) * (kScreenWidth + 10)
        // 设置清扫手势
        let downRecognizer =  UISwipeGestureRecognizer.init(target: self, action: #selector(downAction(recognizer: )))
        downRecognizer.direction = .down
        self.addGestureRecognizer(downRecognizer)
        // 延迟设置点击手势 防止双击立马关闭
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            // 添加单击 手势
            self.addGestureRecognizer(self.tap)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        
        UIApplication.shared.delegate?.window??.addSubview(self)
        // 测试使用与TableView一样的方法在主线程异步添加任务出现有时候会拿不到cell的情况 固只能做延迟调用
//        let queue = DispatchQueue.main
//        print("3333333  \(Thread.current) - \(self.visibleCells.count))")
//        queue.async {
//            print("1111  \(Thread.current) - \(self.visibleCells.count))")
//        }
        // 延迟调用会有闪烁 不能忍受 顾只能用标记来标明 是不是第一次出现来判断是不是需要展示动画详细见 cell 内
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.002, execute:
//            {
//                let cell =  self.visibleCells[0] as! ShowPictureCell
//                let rect = cell.imageView.frame
//                cell.imageView.frame = self.startRect
//                UIView.animate(withDuration: 0.5) {
//                    cell.imageView.frame = rect
//                }
//        })
        
    }
    
    @objc private func hidden() {
        
        
        let cell = self.visibleCells[0] as! ShowPictureCell
        
        cell.scrollView.zoomScale = 1
        let endNum: Int = Int(self.contentOffset.x / kScreenWidth)
        let widthGap: Int = Int(endNum % 3) - Int(pageNum % 3)
        let heighGap: Int = Int(endNum / 3) - Int(pageNum / 3)
        
        let rect = CGRect(x: startRect.origin.x + CGFloat(widthGap) * (startRect.size.width + 10), y: startRect.origin.y + CGFloat(heighGap) * (startRect.size.width + 10), width: startRect.size.width, height: startRect.size.width)
        UIView.animate(withDuration: 0.5, animations: {
            cell.imageView.frame = rect
            self.backgroundColor = .clear
            cell.backgroundColor = .clear
            cell.scrollView.backgroundColor = .clear

        }) { (_) in
            self.removeFromSuperview()
        }
        
    }
    
    @objc func downAction(recognizer: UISwipeGestureRecognizer) {
        // 微信的下滑变小好像有点问题 这里因为时间问题就不继续实现了做了一个清扫关闭
        hidden()
    }
    
    // 手势依赖判断 点击手势是否等另外一个手势识别失败，才能响应
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard tap == gestureRecognizer else {
            return false
        }
        let cell = self.visibleCells[0] as! ShowPictureCell
       return  cell.scrollView.gestureRecognizers!.contains(otherGestureRecognizer)
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "ShowPictureCell", for: indexPath) as!ShowPictureCell
        let path  = Bundle.main.path(forResource: "gastronomy" + imagesArray[indexPath.row], ofType: "jpg")
            cell.image = UIImage(contentsOfFile: path!)
        // 需要在image 后面设置，不然imageView 大小还未设置完成
        if isFristShow && pageNum == indexPath.row {
            cell.startRect = startRect
            isFristShow = false
        }
        return cell
    }
}
