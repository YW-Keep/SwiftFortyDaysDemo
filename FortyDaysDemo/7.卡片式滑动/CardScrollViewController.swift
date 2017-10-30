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
    
    let conllectionView: UICollectionView =  {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.itemSize =  CGSize.init(width: (UIScreen.main.bounds.size.width - 80), height: (UIScreen.main.bounds.size.width - 80)*1.5)
        layout.sectionInset = UIEdgeInsetsMake(0, 40, 0, 40)
        layout.minimumLineSpacing = 20
        let con = UICollectionView.init(frame: CGRect.init(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: (UIScreen.main.bounds.size.width - 80)*1.5), collectionViewLayout: layout)
        con.register(CardScrollCell.self, forCellWithReuseIdentifier: "CardScrollCell")
        con.backgroundColor = UIColor.white
        con.contentSize = CGSize.init(width: UIScreen.main.bounds.size.height, height: 200)
        con.showsHorizontalScrollIndicator = false
//        con.isPagingEnabled = true
        return con
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "卡片式滑动"
        self.view.backgroundColor = UIColor.white
        conllectionView.dataSource = self
        conllectionView.delegate = self
        self.view.addSubview(conllectionView)
        self.getData()
        // Do any additional setup after loading the view.
    }
    func getData() {
        dataArray = [("gastronomy1","这东西看上去好吃啊"),("gastronomy2","这个也不错"),("gastronomy3","晚上看这个会饿啊"),("gastronomy4","都好吃，都好吃"),("gastronomy5","哈哈哈哈哈"),("gastronomy6","我实在是编不下去了,我实在是编不下去了,我实在是编不下去了")]
        self.conllectionView.reloadData()
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
        cell.imgView?.image = UIImage.init(contentsOfFile: path!)
        cell.backgroundColor = UIColor.lightGray
        
        return cell
    }
    // MARK: - UICollectionViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            let offsetX = scrollView.contentOffset.x
            
            let num = offsetX.truncatingRemainder(dividingBy: (UIScreen.main.bounds.size.width - 60))
            var multiple: Int = Int(offsetX / (UIScreen.main.bounds.size.width - 60))
            if num > ((UIScreen.main.bounds.size.width - 60)/2)
            {
                multiple = multiple + 1
                
            }
            var contentOffset = scrollView.contentOffset
            contentOffset.x = CGFloat(multiple) * (UIScreen.main.bounds.size.width - 60)
            scrollView.setContentOffset(contentOffset, animated: true)
        }
        
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let offsetX = targetContentOffset.pointee.x
        
        let num = offsetX.truncatingRemainder(dividingBy: (UIScreen.main.bounds.size.width - 60))
        var multiple: Int = Int(offsetX / (UIScreen.main.bounds.size.width - 60))
        if num > ((UIScreen.main.bounds.size.width - 60)/2)
        {
            multiple = multiple + 1
            
        }
        var nomalMultiple:Int = 0;
        if targetContentOffset.pointee.x > scrollView.contentOffset.x {
            nomalMultiple = Int(scrollView.contentOffset.x / (UIScreen.main.bounds.size.width - 60))
        } else
        {
            nomalMultiple = Int(scrollView.contentOffset.x / (UIScreen.main.bounds.size.width - 60)) + 1
        }
        if multiple > nomalMultiple {
            nomalMultiple = nomalMultiple + 1
        }
        if multiple < nomalMultiple {
            nomalMultiple = nomalMultiple - 1
        }
        targetContentOffset.pointee.x = scrollView.contentOffset.x
        
        var contentOffset = scrollView.contentOffset
        contentOffset.x = CGFloat(nomalMultiple) * (UIScreen.main.bounds.size.width - 60)
        scrollView.setContentOffset(contentOffset, animated: true)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
