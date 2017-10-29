//
//  CardScrollViewController.swift
//  FortyDaysDemo
//
//  Created by 唐余威 on 2017/10/29.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class CardScrollViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
 
    
    let conllectionView: UICollectionView =  {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.itemSize =  CGSize.init(width: UIScreen.main.bounds.size.width, height: 200)
        let con = UICollectionView.init(frame: CGRect.init(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: 200), collectionViewLayout: layout)
        con.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        con.backgroundColor = UIColor.yellow
        con.contentSize = CGSize.init(width: UIScreen.main.bounds.size.height, height: 200)
    
        return con
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "卡片式滑动"
        self.view.backgroundColor = UIColor.white
        conllectionView.dataSource = self
        conllectionView.delegate = self
        self.view.addSubview(conllectionView)
        // Do any additional setup after loading the view.
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        cell.backgroundColor = UIColor.blue
        return cell
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
