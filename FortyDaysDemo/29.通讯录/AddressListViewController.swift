//
//  AddressListViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/12/1.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class AddressListViewController: UIViewController {
    
    var dataArray = [Dictionary<String, Any>]()
    var titleArray = [String]()
    
    lazy var tableView: UITableView = {
        let inTableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), style: .plain)
        
        let nib = UINib(nibName: "AddressListCell", bundle: nil) //nibName指的是我们创建的Cell文件名
        inTableView.register(nib, forCellReuseIdentifier: "AddressListCell")
        inTableView.dataSource = self
        inTableView.delegate = self
        inTableView.rowHeight = 60
        return inTableView;
    }()
    
    var showLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: kScreenWidth - 70, y: 0, width: 40, height: 40))
        label.backgroundColor = .lightGray
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17)
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.isHidden = true
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "通讯录"
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        self.view.addSubview(showLabel)
        self.getData()
         changeIndex()
        // Do any additional setup after loading the view.
    }
    
    func getData() {
        titleArray = ["a","b","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","w","x","w","z"]
        var inData = [Dictionary<String, Any>]()
        for title in titleArray {
            var nameList = [String]()
            let num = Int(arc4random_uniform(9) + 1)
            for _ in 0...num {
                nameList.append(title + String(num))
            }
            inData.append(["title" : title,"list" : nameList])
        }
        self.dataArray = inData
        self.tableView.reloadData()
    }
    func changeIndex() {
        for view in tableView.subviews {
            if view.frame.width == 15 {
                view.gestureRecognizers = nil
                view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(indexTitlesPan(_:))))
            }
        }
    }
    
    @objc fileprivate func indexTitlesPan(_ rgz: UIPanGestureRecognizer) {
        // 计算点击到哪个索引
        let count = titleArray.count
        let IndexTitlesViewHeight: CGFloat = 13.15
        let indexHeight = IndexTitlesViewHeight * CGFloat(count)
        
        let tableViewHeight = tableView.frame.height - NavigationBarHeight
        let startY = (tableViewHeight - indexHeight)/2

        let offsetY = rgz.location(in: rgz.view).y
        var selectIndex = Int((offsetY - startY)/IndexTitlesViewHeight)
        
        print(offsetY)
        if selectIndex < 0 {
            selectIndex = 0
        } else if selectIndex > count - 1 {
            selectIndex = count - 1
        }
        
        // 结束隐藏悬浮View
        if rgz.state == .ended {
            showLabel.isHidden = true
        } else {
            showLabel.text = titleArray[selectIndex]
            showLabel.center = CGPoint(x: showLabel.center.x, y: startY + CGFloat(selectIndex) * IndexTitlesViewHeight + NavigationBarHeight + 6.6)
            showLabel.isHidden = false
        }
        
//        // 因为pan手势会吸收索引原本点击事件,需要自行实现tableView跳转
        tableView.scrollToRow(at: IndexPath(row: 0, section: selectIndex), at: .top, animated: false)
    }
}

extension AddressListViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array: [String] = dataArray[section]["list"] as! [String]
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AddressListCell = tableView.dequeueReusableCell(withIdentifier: "AddressListCell") as! AddressListCell
        let array: [String] = dataArray[indexPath.section]["list"] as! [String]
        cell.titleLabel.text = array[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataArray[section]["title"] as? String
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return titleArray
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        print(title)
        return index
    }
}
