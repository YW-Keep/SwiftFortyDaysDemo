//
//  RecorderViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/16.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class RecorderViewController: UIViewController, RecorderManagerDeleagte {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var recorderButton: UIButton!
    let recorderManager = RecorderManager()
    
    var dataArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "语音备忘录"
        let nib = UINib(nibName: "RecorderCell", bundle: nil) //nibName指的是我们创建的Cell文件名
        tableView.register(nib, forCellReuseIdentifier: "RecorderCell")
        tableView.rowHeight = 60
        recorderManager.delegate = self
        
        getDate()
        // Do any additional setup after loading the view.
    }
    
    func getDate() {
        dataArray = recorderManager.getNameList()
        tableView.reloadData()
    }
    
    deinit {
        print("页面释放")
    }
}

// 录音部分
extension RecorderViewController {
    
    @IBAction func playAction(_ sender: UIButton) {
        if !sender.isSelected {
            recorderManager.play()
            recorderButton.isEnabled = false
            completeButton.isEnabled = false
            
        } else {
            recorderManager.pausePlay()
            recorderButton.isEnabled = true
            completeButton.isEnabled = true
        }
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func completeAction(_ sender: UIButton) {
        playButton.isEnabled = false
        completeButton.isEnabled = false
        
        let alertCol = UIAlertController(title: "保存语音",
                                         message: "",
                                         preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "保存", style: .default) { (_) in
            if let textField = alertCol.textFields?.first {
                let queue = DispatchQueue.main
                queue.async {
                    self.recorderManager.saveVideo(name: textField.text ?? "语音")
                }
            }
        }
        let cancelAction = UIAlertAction(title: "删除",
                                         style: .default) { (_) in
            self.recorderManager.deleteVideo()
        }
        
        alertCol.addTextField()
        alertCol.addAction(saveAction)
        alertCol.addAction(cancelAction)
        present(alertCol, animated: true)
    }
    
    @IBAction func tapingAndPauseAction(_ sender: UIButton) {
        if !sender.isSelected {
            recorderManager.begainRecord()
            recorderManager.stopPlay()
            playButton.isEnabled = false
            completeButton.isEnabled = false
        } else {
            recorderManager.stopRecord()
            playButton.isEnabled = true
            completeButton.isEnabled = true
        }
        sender.isSelected = !sender.isSelected
    }
    
    func endPlay() {
        playAction(playButton)
    }
    
    func endAddRecord() {
        getDate()
    }
}

extension RecorderViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecorderCell") as! RecorderCell
        cell.titleLabel.text = dataArray[indexPath.row]
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
       
        let  delect = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "删除") { (rowAction, indexPath) in
            self.recorderManager.deleteVideo(name: self.dataArray[indexPath.row])
            self.dataArray.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
            
        }
        
        return [delect]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let col = VideoPlayViewController()
        col.name = dataArray[indexPath.row]
        self.show(col, sender: nil)
    }
}
