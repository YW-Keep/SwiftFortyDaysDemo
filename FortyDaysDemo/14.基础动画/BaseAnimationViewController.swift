//
//  BaseAnimationViewController.swift
//  FortyDaysDemo
//
//  Created by 唐余威 on 2017/11/4.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class BaseAnimationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let dataArry: [(name:String,control:String)] = [("基础动画","PositionAnimationViewController"),("核心动画","CoreAnimationViewController"),("粒子动画(发射器)","EmitterViewController")]

    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), style: .grouped)
        view.dataSource = self
        view.delegate = self
        view.rowHeight = 40
        return view;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "基础动画"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        // Do any additional setup after loading the view.
    }
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArry.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "RefreshCell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.value1, reuseIdentifier: "RefreshCell")
            cell?.selectionStyle = .none
        }
        cell?.textLabel?.text = dataArry[indexPath.row].name
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        let classType = NSClassFromString(namespace + "." + dataArry[indexPath.row].control) as? UIViewController.Type
        if let type = classType {
            self.navigationController?.pushViewController(type.init(), animated: true)
            print(type)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
