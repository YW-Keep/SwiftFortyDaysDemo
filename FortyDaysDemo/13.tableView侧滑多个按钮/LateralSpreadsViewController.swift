//
//  LateralSpreadsViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/3.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class LateralSpreadsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var dateArray = ["1","2","3","4","5","6","7","8","9"]
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), style: .grouped)
        view.dataSource = self
        view.delegate = self
        view.rowHeight = 60
        return view;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "tableView侧滑多个按钮"
        self.view.addSubview(tableView)
        // Do any additional setup after loading the view.
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "RefreshCell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.value1, reuseIdentifier: "RefreshCell")
            cell?.selectionStyle = .none
        }
        cell?.textLabel?.text = dateArray[indexPath.row] + ".我就是个测试的假数据忽略我"
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let  share  = UITableViewRowAction(style: .normal, title: "分享分享") { (rowAction, indexPath) in
            let activityViewController = UIActivityViewController(activityItems: [self.dateArray[indexPath.row]], applicationActivities: nil)
            
            self.present(activityViewController, animated: true, completion: nil)
        }
        share.backgroundColor = UIColor.lightGray
        
        let  topper  = UITableViewRowAction(style: .normal, title: "置顶") { (rowAction, indexPath) in
            let data = self.dateArray[indexPath.row]
            self.dateArray.remove(at: indexPath.row)
            self.dateArray.insert(data, at: 0)
            self.tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
        }
        topper.backgroundColor = UIColor.gray
        
        let  delect = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "删除") { (rowAction, indexPath) in
            self.dateArray.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
           
        }
    
        return [delect, share, topper]
    }
    
}
