//
//  NewsTitleView.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/29.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit
protocol TitleSelectorDeleagte: class {
    func titleSelected(_ selecterNum: Int)
}

class NewsTitleView: UICollectionView {
    
    weak var selectorDelegate: TitleSelectorDeleagte?
    // 获取的数据
    var dataArray: [NewsListModel] {
        didSet{
            self.reloadData()
        }
    }
    
    // 一个记录选中状态的值
    var selectorNum: Int = 0
    
     override private init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        dataArray = []
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.register(NewsTitleCell.self, forCellWithReuseIdentifier: "NewsTitleCell")
        self.backgroundColor = .white
        self.showsHorizontalScrollIndicator = false
    }
    convenience init(frame: CGRect) {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.itemSize = CGSize(width: 60, height: 40)
        layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20)
        layout.minimumLineSpacing = 20
        
        self.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewsTitleView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "NewsTitleCell", for: indexPath) as!NewsTitleCell
        cell.titleLabel.text = dataArray[indexPath.row].title
        cell.titleLabel.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == selectorNum {
            (cell as! NewsTitleCell).mySelected = true
        } else {
            (cell as! NewsTitleCell).mySelected = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let beforeCell = collectionView.cellForItem(at: IndexPath(row: selectorNum, section: 0)) as? NewsTitleCell
        beforeCell?.mySelected = false
        let nowCell = collectionView.cellForItem(at: indexPath) as? NewsTitleCell
        nowCell?.mySelected = true
        selectorNum = indexPath.row
        selectorDelegate?.titleSelected(selectorNum)
    }
}

extension NewsTitleView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: dataArray[indexPath.row].width, height: 20)
    }
}

//MARK:-NewsTitleCell
class NewsTitleCell : UICollectionViewCell {
    var titleLabel: UILabel
    
    // 没有用系统了 为了防止引起系统自定义的点击效果
     var mySelected: Bool {
        didSet {
            self.titleLabel.textColor = self.mySelected ? .red : .lightGray
            self.titleLabel.font = UIFont.systemFont(ofSize: self.mySelected ? 18 : 15)
        }
    }
    override init(frame: CGRect) {
        titleLabel = UILabel()
        mySelected = false
        super.init(frame: frame)
        titleLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = .lightGray
        self.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
