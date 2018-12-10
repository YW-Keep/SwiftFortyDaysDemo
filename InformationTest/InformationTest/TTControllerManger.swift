//
//  TTControllerManger.swift
//  InformationTest
//
//  Created by 唐余威 on 2018/12/10.
//  Copyright © 2018 唐余威. All rights reserved.
//

import UIKit

class TTControllerManger: NSObject {
    static let shared = TTControllerManger()
    var  rootViewControl : UITabBarController
    private override init() {
        rootViewControl = UITabBarController()
        let col1 = UIViewController()
        col1.tabBarItem.title = "首页"
        col1.view.backgroundColor = .yellow
        let col2 = UIViewController()
        col2.view.backgroundColor = .blue
        col2.tabBarItem.title = "发现"
        let col3 = UIViewController()
        col3.tabBarItem.title = "我的"
        col3.view.backgroundColor = .red
        rootViewControl.tabBar.isTranslucent = false
        rootViewControl.setViewControllers([col1,col2,col3], animated: false)
        super.init()
        
    }
}
