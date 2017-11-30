//
//  ContentView.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/30.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class ContentView: UICollectionView {
    
    // 获取的数据
    var dataArray: [NewsListModel] {
        didSet{
            self.reloadData()
        }
    }
    
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
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("11")
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("22")
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
         print("333")
    }
}

extension ContentView: TitleSelectorDeleagte {
    func titleSelected(_ selecterNum: Int) {
        self.contentOffset = CGPoint(x: self.frame.width * CGFloat(selecterNum), y: self.contentOffset.y)
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
