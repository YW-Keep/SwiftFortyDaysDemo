//
//  WaterfallFlowViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/15.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

/*
 思路
 把collectionView分割成若干列，由数组保存每一列的高度
 每次设置UICollectionViewLayoutAttributes的时候，获取最短一列
 计算出图片的size，然后添加到最短一列上面。
 */

class WaterfallFlowViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout  = WaterfallFlowLayout()
        layout.delegate = self 
        let con = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), collectionViewLayout: layout)
        con.register(WaterfallFlowCell.self, forCellWithReuseIdentifier: "WaterfallFlowCell")
        con.backgroundColor = UIColor.white
        con.showsHorizontalScrollIndicator = false
        con.showsVerticalScrollIndicator = false
        con.dataSource = self
        return con
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "瀑布流"
        self.view.addSubview(collectionView)
        // Do any additional setup after loading the view.
    }

}

extension WaterfallFlowViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 58
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WaterfallFlowCell", for: indexPath) as!WaterfallFlowCell
        let imageName = "petPicture" + String(indexPath.row%10)
        cell.imageView.image = UIImage(named: imageName)
        // imageView 用代码创建时宽高写死了 需要动态修改
        cell.imageView.frame = CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height)
        return cell
    }
}

extension WaterfallFlowViewController: WaterfallFlowLayoutDeleagte {
    
    func AspectRatioForIndexPath(indexPath: IndexPath) -> CGFloat {
        let imageName = "petPicture" + String(indexPath.row%10)
        let image = UIImage(named: imageName)!
        return image.size.height / image.size.width
    }
}
