//
//  FriendsCircleViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/10.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit
/*
 有个约束冲突没想明白
 */
class FriendsCircleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dataAarry: [FriendsMessage] = []
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), style: .grouped)
        view.dataSource = self
        view.delegate = self
        let nib = UINib(nibName: "FriendsCircleCell", bundle: nil) //nibName指的是我们创建的Cell文件名
        view.register(nib, forCellReuseIdentifier: "FriendsCircleCell")
        view.estimatedRowHeight = 80
        view.rowHeight = UITableViewAutomaticDimension
        return view;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "简略朋友圈"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        getData()
        // Do any additional setup after loading the view.
    }
    private func getData() {
        let model1 = FriendsMessage(messageName: "阿狸", messageIcon: "HeadIconImg", messageContent: "测试数据测试数据测试数据测试数据", messageImages: [])
        let model2 = FriendsMessage(messageName: "阿狸", messageIcon: "HeadIconImg", messageContent: "测试数据测试数据测试数据测试数据", messageImages: ["1","3","4"])
        let model3 = FriendsMessage(messageName: "阿狸", messageIcon: "HeadIconImg", messageContent: "测试数据测试数据测试数据测试数据", messageImages: ["1","3","4","2","6"])
        let model4 = FriendsMessage(messageName: "狗狗", messageIcon: "CameraImg", messageContent: "测试数据测试数据测测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据试数据测试数据", messageImages: ["1","3","4","2","6","5","1","3","2"])
        let model5 = FriendsMessage(messageName: "狗狗", messageIcon: "CameraImg", messageContent: "测试数据测试数据测测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据试数据测试数据", messageImages: ["1","3"])
        let model6 = FriendsMessage(messageName: "狗狗", messageIcon: "CameraImg", messageContent: "测试数据测试数据测测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据试数据测试数据", messageImages: [])
        
        dataAarry = [model1, model2, model3, model4, model5, model6]
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataAarry.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell: FriendsCircleCell = tableView.dequeueReusableCell(withIdentifier: "FriendsCircleCell") as! FriendsCircleCell
        cell.model = dataAarry[indexPath.row]
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

}
