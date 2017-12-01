//
//  ContentView.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/30.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

protocol ContentSelectorDeleagte: class {
    func contentSelected(_ selecterNum: Int)
    func scrollCell(selectorNum: Int, changeNum: Int, changeRatio: CGFloat)
}


class ContentView: UICollectionView {
    
    // 获取的数据
    var dataArray: [NewsListModel] {
        didSet{
            self.reloadData()
        }
    }
    private var pageNum = 0
    
    private var isIgnoreSelector = false
    
    weak var contentDeleagte: ContentSelectorDeleagte?
    
    override private init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        dataArray = []
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.register(ContentCell.self, forCellWithReuseIdentifier: "ContentCell")
        self.backgroundColor = .white
        self.showsHorizontalScrollIndicator = false
        self.isPagingEnabled = true
    }
    convenience init(frame: CGRect) {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.itemSize = CGSize(width: kScreenWidth, height: kScreenHeight - 40)
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumLineSpacing = 0
        
        self.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContentView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCell", for: indexPath) as!ContentCell
        cell.titleLabel.text = dataArray[indexPath.row].title
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 修正点击后调用冲突
        if isIgnoreSelector {
            isIgnoreSelector = false
            return
        }
        
        // 滑动过头 不做修改
        if contentOffset.x < 0 || contentOffset.x > CGFloat(dataArray.count - 1) * kScreenWidth {
            return
        }
        
        let selectorNum = pageNum
        var changeNum = 0
        var ratio : CGFloat = 0
        if self.contentOffset.x < kScreenWidth * CGFloat(pageNum) {
            changeNum = selectorNum - 1
            ratio = (kScreenWidth * CGFloat(pageNum) - self.contentOffset.x) / kScreenWidth
        } else {
            ratio = (self.contentOffset.x - kScreenWidth * CGFloat(pageNum)) / kScreenWidth
            changeNum = selectorNum + 1
        }
        ratio = ratio > 1 ? 1 : ratio
        self.contentDeleagte?.scrollCell(selectorNum: selectorNum, changeNum: changeNum, changeRatio: ratio)
    }
    
    // 结束后修改位置
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageNum = Int(scrollView.contentOffset.x / kScreenWidth)
        contentDeleagte?.contentSelected(pageNum)
        
    }
}

extension ContentView: TitleSelectorDeleagte {
    func titleSelected(_ selecterNum: Int) {
        isIgnoreSelector = true
        self.contentOffset = CGPoint(x: self.frame.width * CGFloat(selecterNum), y: self.contentOffset.y)
        pageNum = selecterNum
       
    }
}

//MARK:-ContentCell
class ContentCell : UICollectionViewCell {
    var titleLabel: UILabel
    
    override init(frame: CGRect) {
        titleLabel = UILabel()
        super.init(frame: frame)
        titleLabel.frame = CGRect(x: 0, y: 200, width:kScreenWidth, height: 100)
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 30)
        titleLabel.textColor = .lightGray
        self.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
