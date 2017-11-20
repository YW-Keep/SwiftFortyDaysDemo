//
//  RefreshViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/1.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class RefreshViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var dataNum = 2
    
    lazy var refreshCol: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "没想好怎么刷~")
        refresh.tintColor = UIColor.lightGray
        refresh.addTarget(self, action: #selector(reloadData), for:.valueChanged)
        return refresh
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), style: .grouped)
        view.dataSource = self
        view.delegate = self
        view.rowHeight = 40
        view.refreshControl = refreshCol
        return view;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "上拉刷新与下拉加载"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        
        // Do any additional setup after loading the view.
    }
    @objc func reloadData()  {
        
        self.perform(#selector(changeData), with: nil, afterDelay: 2)
    }
    @objc func changeData() {
        dataNum = Int(arc4random_uniform(10)) + 1
        refreshCol.endRefreshing()
        tableView.reloadData()
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
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }

}
