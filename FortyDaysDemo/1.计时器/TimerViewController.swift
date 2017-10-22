//
//  TimerViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/10/19.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController,UITableViewDataSource {
    @IBOutlet weak var showLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var timer : Timer!
    var ms: UInt8 = 0
    var sec: UInt8 = 0
    var min: UInt8 = 0
    var listArray:[String] = []
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "计时器"
        leftButton.layer.cornerRadius = 25
        leftButton.layer.masksToBounds = true
        rightButton.layer.cornerRadius = 25
        rightButton.layer.masksToBounds = true
        showLabel.font = UIFont(name: "Menlo-Italic", size: 40)
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if (timer != nil) {
         timer.invalidate()
        }
    }
    
    // MARK: - 操作
    // 左边的按钮事件
    @IBAction func leftButtonAction(_ sender: UIButton) {
        if sender.title(for: UIControlState.normal) == "计次" {
            if rightButton.title(for: UIControlState.normal) == "停止" {
                self.would()
            }
        } else {
            sender.setTitle("计次", for: UIControlState.normal)
            sender.backgroundColor = UIColor.darkGray
            sender.endEditing(false)
            self.reset()
        }
    }
    // 右边的按钮事件
    @IBAction func rightButtonAction(_ sender: UIButton) {
    
        if sender.title(for: UIControlState.normal) == "启动" {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.replyAction), userInfo: nil, repeats: true)
            RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
            sender.backgroundColor = UIColor(red: 177/255.0, green: 31/255.0, blue: 0/255.0, alpha: 0.5)
            sender.setTitle("停止", for: UIControlState.normal)
            leftButton.setTitle("计次", for: UIControlState.normal)
            leftButton.backgroundColor = UIColor.gray
            leftButton.endEditing(true)

        } else {
            sender.backgroundColor = UIColor(red: 84/255.0, green: 184/255.0, blue: 100/255.0, alpha: 1)
            sender.setTitle("启动", for: UIControlState.normal)
            leftButton.setTitle("复位", for: UIControlState.normal)
            timer.invalidate()
        }
        
    }
    //重复的修改方法
    @objc func replyAction() {
        ms += 1
        if ms == 100 {
            ms = 0
            sec += 1
            if sec == 60 {
                sec = 0
                min = +1
                if min == 60 {  min = 0 }
            }
        }
        showLabel.text = String(format: "%02d", min) + ":" + String(format: "%02d", sec) + "." + String(format: "%02d", ms)
    }
    // 复位
    func reset() {
        ms = 0
        sec = 0
        min = 0
        listArray = []
        showLabel.text = "00:00.00"
        tableView.reloadData()
    }
    // 计次
    func would() {
        listArray.append(showLabel.text!)
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell.init(style: UITableViewCellStyle.value1, reuseIdentifier: "Timer")
        let title  = "计次" + String(indexPath.row + 1)
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = listArray[indexPath.row]
        cell.detailTextLabel?.font = UIFont(name: "Menlo-Italic", size: 15)
        return cell
    }
    deinit {
        print("定时器页面释放")
    }
}
