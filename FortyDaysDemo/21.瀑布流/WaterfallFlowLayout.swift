//
//  WaterfallFlowLayout.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/15.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

protocol WaterfallFlowLayoutDeleagte {
    
    // 必须实现这协议来进行计算  高宽比 知道比里 宽度已定所以高度就知道了
     func AspectRatioForIndexPath(indexPath: IndexPath) -> CGFloat
}

class WaterfallFlowLayout: UICollectionViewFlowLayout {
    
    // 列数 默认3
    var columnNum = 3
    
    // 列间距 默认10
    var columnMargin: CGFloat = 10
    
    // 行间距 默认 10
    var rowMargin: CGFloat = 10
    
    // 内边距 默认 10
    var sectionInsetes = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    // 协议
    var delegate : WaterfallFlowLayoutDeleagte?
    
    // 储存每个item的布局属性的数组
    private var attrArray = [UICollectionViewLayoutAttributes]()
    
    // 储存高度的数组
    private var heightArray = [CGFloat]()
    
    
    
    // 系统在准备对item进行布局前会调用这个方法
    override func prepare() {
        super.prepare()
        
        // 清除缓存
        attrArray.removeAll()
        heightArray.removeAll()
        
        //初始化高度数据
        for _ in 0..<columnNum {
            heightArray.append(self.sectionInsetes.top)
        }
        
        let num = self.collectionView?.numberOfItems(inSection: 0)
        for i in 0..<num! {
            //获取每个item
            let index = IndexPath(item: i, section: 0)
            //设置item的属性
            let attr = UICollectionViewLayoutAttributes(forCellWith: index)
            attr.frame = computationsFrameForIndex(indexPath: index)
            attrArray.append(attr)
        }
        
    }
    
    // 计算每个cell 的frame
    func computationsFrameForIndex(indexPath: IndexPath) -> CGRect {
        //找出高度最短的那一列。并记录
        var minHeight = heightArray[0]
        var minIdex = 0
        for i in 1..<columnNum{
            if minHeight > heightArray[i] {
                minHeight = heightArray[i]
                minIdex = i
            }
        }
        let viewWidth = self.collectionView?.bounds.size.width
        
        let width = (viewWidth! - sectionInsetes.left - sectionInsetes.right - CGFloat(columnNum - 1) * columnMargin) / CGFloat(columnNum)
        let x = sectionInsetes.left + CGFloat(minIdex) * (width + columnMargin)
        let height = (delegate?.AspectRatioForIndexPath(indexPath: indexPath) ?? 0) * width
        heightArray[minIdex] = minHeight + height + rowMargin
        return CGRect(x: x, y: minHeight, width: width, height: height)
    }
    
//    //  这个可以返回没一个item的Attributes 但是为了滑动流畅，事先先算完返回数据比较好
//    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
//        attr.frame = computationsFrameForIndex(indexPath: indexPath)
//        return attr
//    }
    
    /*
     collectionView调用这个方法并将自身坐标系统中的矩形传过来，这个矩形代表着当前collectionView可视的范围
     我们需要在这个方法里面返回一个包括UICollectionViewLayoutAttributes对象的数组，
     这个布局属性对象决定了当前显示的item的大小、层次、可视属性在内的布局属性。
    */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrArray
    }
    
    // 复写contentSize的get 方法 返回最大值
    override var collectionViewContentSize: CGSize {
        var maxHeight = heightArray[0]
        for index in 1..<columnNum {
            if heightArray[index] > maxHeight {
                maxHeight = heightArray[index]
            }
        }
        return CGSize(width: self.collectionView?.frame.size.width ?? 0, height:maxHeight)
    }
}
