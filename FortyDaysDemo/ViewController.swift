//
//  ViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/10/18.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    lazy var listArry:[(name:String,control:String)] = {
        return [("计时器","TestViewController")]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "40天demo列表"
        // 修改返回按钮上的字
        let backButton = UIBarButtonItem.init()
        backButton.title = ""
        self.navigationItem.backBarButtonItem = backButton
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArry.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "HomeListCell")
        let title  = String(indexPath.row + 1) + "." + listArry[indexPath.row].name
        cell.textLabel?.text = title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 获取类名，push
        let date = listArry[indexPath.row]
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        let classType = NSClassFromString(namespace + "." + date.control) as? UIViewController.Type
        if let type = classType {
            self.navigationController?.pushViewController(type.init(), animated: true)
            print(type)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

