//
//  CardScrollViewController.swift
//  FortyDaysDemo
//
//  Created by 唐余威 on 2017/10/29.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class CardScrollViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    var dataArray:[(imageString:String,title:String)] = []
    // 在目标偏移量为当前偏移量时 会再调用scrollViewDidEndDragging  所以要排异调避免冲突
    var isIgnore = false
    lazy var conllectionView: UICollectionView =  {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.itemSize =  CGSize.init(width: (UIScreen.main.bounds.size.width - 120), height: (UIScreen.main.bounds.size.width - 120)*1.5)
        layout.sectionInset = UIEdgeInsetsMake(0, 60, 0, 60)
        layout.minimumLineSpacing = 20
        let con = UICollectionView.init(frame: CGRect.init(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: (UIScreen.main.bounds.size.width - 120)*1.5), collectionViewLayout: layout)
        con.register(CardScrollCell.self, forCellWithReuseIdentifier: "CardScrollCell")
        con.backgroundColor = UIColor.white
        con.showsHorizontalScrollIndicator = false
        con.dataSource = self
        con.delegate = self
//        con.isPagingEnabled = true
        return con
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "卡片式滑动"
        self.view.backgroundColor = UIColor.white
 
        self.view.addSubview(conllectionView)
        self.getData()
        // Do any additional setup after loading the view.
    }
    func getData() {
        dataArray = [("gastronomy1","这东西看上去好吃啊"),("gastronomy2","这个也不错"),("gastronomy3","晚上看这个会饿啊"),("gastronomy4","都好吃，都好吃"),("gastronomy5","哈哈哈哈哈"),("gastronomy6","我实在是编不下去了,我实在是编不下去了,我实在是编不下去了")]
        self.conllectionView.reloadData()
        // 因为刷新应该是在异步添加在主线程，所以我初始化也赋值也在这时候
        let queue = DispatchQueue.main
        queue.async {
            self.scrollViewDidScroll(self.conllectionView)
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "CardScrollCell", for: indexPath) as!CardScrollCell
        let data = dataArray[indexPath.row];
        cell.titleLabel?.text = data.title
        let path  = Bundle.main.path(forResource: data.imageString, ofType: "jpg")
        cell.imgView?.image = UIImage(contentsOfFile: path!)
        cell.backgroundColor = UIColor.lightGray
        
        return cell
    }
    // MARK: - UICollectionViewDelegate
    // 滚动过程中一直调用
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let numCenter = scrollView.contentOffset.x + (UIScreen.main.bounds.size.width - 100) / 2.0
        let nowNum = Int(numCenter / (UIScreen.main.bounds.size.width - 100)) ;
        let beforeNum = nowNum - 1;
        let lastNum =  nowNum + 1;
        
        if nowNum >= 0 {
            let spacing = fabs((UIScreen.main.bounds.size.width - 100) * CGFloat(nowNum) -  scrollView.contentOffset.x)
            var nowMultiple =  CGFloat(spacing) / CGFloat(UIScreen.main.bounds.size.width - 100)
            if nowMultiple > 1 {
                nowMultiple = 1
            }
            let nowCell = conllectionView.cellForItem(at: IndexPath.init(row: Int(nowNum), section: 0))
            nowCell?.layer.setAffineTransform(CGAffineTransform.init(scaleX: (0.9 + 0.1 * (1 - nowMultiple)), y:(0.9 + 0.1 * (1 - nowMultiple))))
        }
        
        if beforeNum >= 0 {
            let spacing = fabs((UIScreen.main.bounds.size.width - 100) * CGFloat(beforeNum) -  scrollView.contentOffset.x)
            var nowMultiple =  CGFloat(spacing) / CGFloat(UIScreen.main.bounds.size.width - 100)
            if nowMultiple > 1 {
                nowMultiple = 1
            }
            let Cell = conllectionView.cellForItem(at: IndexPath.init(row: Int(beforeNum), section: 0))
            Cell?.layer.setAffineTransform(CGAffineTransform.init(scaleX: (0.9 + 0.1 * (1 - nowMultiple)), y:(0.9 + 0.1 * (1 - nowMultiple))))
        }
        
        if lastNum < dataArray.count  {
            let spacing = fabs((UIScreen.main.bounds.size.width - 100) * CGFloat(lastNum) -  scrollView.contentOffset.x)
            var nowMultiple =  CGFloat(spacing) / CGFloat(UIScreen.main.bounds.size.width - 100)
            if nowMultiple > 1 {
                nowMultiple = 1
            }
            let Cell = conllectionView.cellForItem(at: IndexPath.init(row: Int(lastNum), section: 0))
            Cell?.layer.setAffineTransform(CGAffineTransform.init(scaleX: (0.9 + 0.1 * (1 - nowMultiple)), y:(0.9 + 0.1 * (1 - nowMultiple))))
        }
    }
    
    // 手指移开时调用
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            if isIgnore {
                isIgnore = false
                return
            }
            let offsetX = scrollView.contentOffset.x
            
            let num = offsetX.truncatingRemainder(dividingBy: (UIScreen.main.bounds.size.width - 100))
            var multiple: Int = Int(offsetX / (UIScreen.main.bounds.size.width - 100))
            if num > ((UIScreen.main.bounds.size.width - 100)/2)
            {
                multiple = multiple + 1
                
            }
            var contentOffset = scrollView.contentOffset
            contentOffset.x = CGFloat(multiple) * (UIScreen.main.bounds.size.width - 100)
            scrollView.setContentOffset(contentOffset, animated: true)
        }
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        // 判断目标位置，从而修改滑块
        let offsetX = targetContentOffset.pointee.x
        let num = offsetX.truncatingRemainder(dividingBy: (UIScreen.main.bounds.size.width - 100))
        var multiple: Int = Int(offsetX / (UIScreen.main.bounds.size.width - 100))
        if num > ((UIScreen.main.bounds.size.width - 100)/2)
        {
            multiple = multiple + 1
            
        }
        var nomalMultiple:Int = 0;
        if targetContentOffset.pointee.x > scrollView.contentOffset.x {
            nomalMultiple = Int(scrollView.contentOffset.x / (UIScreen.main.bounds.size.width - 100))
        } else
        {
            nomalMultiple = Int(scrollView.contentOffset.x / (UIScreen.main.bounds.size.width - 100)) + 1
        }
        if multiple > nomalMultiple {
            nomalMultiple = nomalMultiple + 1
        }
        if multiple < nomalMultiple {
            nomalMultiple = nomalMultiple - 1
        }
        targetContentOffset.pointee.x = scrollView.contentOffset.x
        self.isIgnore = true
        var contentOffset = scrollView.contentOffset
        contentOffset.x = CGFloat(nomalMultiple) * (UIScreen.main.bounds.size.width - 100)
        scrollView.setContentOffset(contentOffset, animated: true)
    }
}
