//
//  NewsViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/29.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    lazy var titleView: NewsTitleView = {
        let view = NewsTitleView(frame: CGRect(x: 0, y: NavigationBarHeight, width: kScreenWidth, height: 50))
        return view
    }()
    
    lazy var contentView: ContentView = {
        let view = ContentView(frame: CGRect(x: 0, y: NavigationBarHeight + 40, width: kScreenWidth, height: kScreenHeight - 40))
         return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "新闻"
   
        self.view.backgroundColor = .white
        self.view.addSubview(titleView)
        self.view.addSubview(contentView)
        titleView.selectorDelegate = contentView
        getData()
        // Do any additional setup after loading the view.
    }
    
    func getData() {
        let baseArray = ["测试","主要新闻","科技","财经","aaaa","bbbbbbb","ccccc","游戏","生活","测试","主要新闻","科技","财经","aaaa","bbbbbbb","cccc","游戏","生活"]
        var data: [NewsListModel] = []
        for title in baseArray {
            data.append(NewsListModel(title))
        }
        titleView.dataArray = data
        contentView.dataArray = data
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
