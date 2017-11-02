//
//  TableViewGradientController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/2.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class TableViewGradientController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var listData: Int = 13
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), style: .grouped)
        view.dataSource = self
        view.delegate = self
        view.rowHeight = 50
        view.separatorStyle = .none
        return view;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "列表颜色渐变"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        self.tableViewAnimation()
        // Do any additional setup after loading the view.
    }
    
    func tableViewAnimation() {
        // 不刷新是不会show动画的
        tableView.reloadData()
        let cells  = tableView.visibleCells ;
        var index = 0
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: kScreenHeight)
            // spring Animation 动画 酷炫的一匹  可以做弹性动画
            UIView.animate(withDuration: 1.5, delay: 0.05*Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            
            index += 1
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "RefreshCell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.value1, reuseIdentifier: "RefreshCell")
            cell?.selectionStyle = .none
            cell?.textLabel?.textColor = UIColor.white
        }
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 50)
        layer.colors = colorForRow(row: indexPath.row)
        layer.locations = [0,1]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        cell?.layer.insertSublayer(layer, at: 0)
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
    // MARK: - 私有方法
    func colorForRow(row: Int) -> Array<Any> {
        let color =  (CGFloat(row) / CGFloat(listData - 1)) * 0.8
        return [UIColor(red:1,  green: color,  blue:0.0,  alpha:1.0).cgColor,UIColor(red:1.0,  green: color * 0.8,  blue:0.0,  alpha:1.0).cgColor]
    }

}
