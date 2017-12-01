//
//  AddressListViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/12/1.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class AddressListViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let inTableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), style: .grouped)
        
        let nib = UINib(nibName: "AddressListCell", bundle: nil) //nibName指的是我们创建的Cell文件名
        inTableView.register(nib, forCellReuseIdentifier: "AddressListCell")
        inTableView.dataSource = self
        inTableView.delegate = self
        inTableView.rowHeight = 60
        return inTableView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "通讯录"
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        // Do any additional setup after loading the view.
    }
    
}

extension AddressListViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AddressListCell = tableView.dequeueReusableCell(withIdentifier: "AddressListCell") as! AddressListCell
        
        return cell
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
