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
        contentView.contentDeleagte = titleView
        getData()
        // Do any additional setup after loading the view.
    }
    
    func getData() {
        let baseArray = ["测试1","测试22","测试333","测试4444","测试5","测试6","测试7","测试8","测试9","测试101010","测试11","测试12","测试13","测试14","测试15","测试16","测试17","测试18"]
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
