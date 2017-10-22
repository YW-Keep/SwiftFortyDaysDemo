//
//  LocalVideoViewController.swift
//  FortyDaysDemo
//
//  Created by 唐余威 on 2017/10/22.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit
import AVKit

class LocalVideoViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    lazy var tableView: UITableView = {
        return UITableView.init(frame: self.view.frame, style: UITableViewStyle.grouped)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(tableView)
        self.title = "本地视频播放"
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "LocalVideoCell", bundle: nil) //nibName指的是我们创建的Cell文件名
        tableView.register(nib, forCellReuseIdentifier: "LocalVideoCell")
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocalVideoCell", for: indexPath) as! LocalVideoCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 241
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //定义一个视频文件路径
        let filePath = Bundle.main.path(forResource: "测试视频", ofType: "mov")
        //创建播放视频的VC
        let playerView = AVPlayerViewController()
        let player = AVPlayer.init(url: URL.init(fileURLWithPath: filePath!))
        playerView.player = player
        self.showDetailViewController(playerView, sender: nil)
        player.play()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
