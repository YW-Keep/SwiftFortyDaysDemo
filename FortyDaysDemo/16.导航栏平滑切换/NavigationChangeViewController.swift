//
//  NavigationChangeViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/7.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class NavigationChangeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var dataNum = 25
    
     fileprivate var statusBarShouldLight = true
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), style: .grouped)
        view.dataSource = self
        view.delegate = self
        view.rowHeight = 40
        view.backgroundColor = UIColor(red: 255/255.0, green: 127/255.0, blue: 0/255.0, alpha: 1)
        return view;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.navBarAlpha = 0
        self.navBarTintColor = .white
        self.view.addSubview(tableView)
        if #available(iOS 11, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if statusBarShouldLight {
            return .lightContent
        } else {
            return .default
        }
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataNum;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "RefreshCell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.value1, reuseIdentifier: "RefreshCell")
            cell?.selectionStyle = .none
        }
        cell?.textLabel?.text = String(indexPath.row) + ".我就是个测试的假数据忽略我"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view  = UIView()
        view.backgroundColor = UIColor(red: 255/255.0, green: 127/255.0, blue: 0/255.0, alpha: 1)
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let col = UIViewController()
        col.view.backgroundColor = .white
        self.show(col, sender: nil)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let contentOffsetY = scrollView.contentOffset.y
        let showNavBarOffsetY: CGFloat = 200 - 64 - 40
        
        //navigationBar alpha
        if contentOffsetY > showNavBarOffsetY  {
            var navAlpha = (contentOffsetY - (showNavBarOffsetY)) / 40.0
            if navAlpha > 1 {
                navAlpha = 1
            }
            navBarAlpha = navAlpha
            if navAlpha > 0.8 {
                navBarTintColor = UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1.0)
                statusBarShouldLight = false
                
            }else{
                navBarTintColor = UIColor.white
                statusBarShouldLight = true
            }
        }else{
            navBarAlpha = 0
            navBarTintColor = UIColor.white
            statusBarShouldLight = true
        }
        setNeedsStatusBarAppearanceUpdate()
    }

}
