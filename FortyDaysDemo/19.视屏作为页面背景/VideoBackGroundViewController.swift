//
//  VideoBackGroundViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/9.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit
import AVKit

class VideoBackGroundViewController: UIViewController {
    lazy var playerLayer: AVPlayerLayer = {
        //定义一个视频文件路径
        let filePath = Bundle.main.path(forResource: "背景视频", ofType: "mov")
        let  playerItem = AVPlayerItem(url: URL.init(fileURLWithPath: filePath!))
        //创建播放视频的VC
        let player = AVPlayer(playerItem: playerItem)
        let layer = AVPlayerLayer(player: player)
        layer.frame = self.view.frame
        NotificationCenter.default.addObserver(self, selector:  #selector(playAgain(notification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        return layer
    }()
    
    lazy var pushButton: UIButton = {
       let button = UIButton(frame: CGRect(x: 0, y: kScreenHeight - 80, width: 120, height: 40))
        button.center.x = self.view.center.x
        button.backgroundColor = UIColor.white
        button.setTitle("马上进入", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(pushAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "视屏为背景"
        self.view.backgroundColor = UIColor.white
        self.view.layer.addSublayer(playerLayer)
        self.view.addSubview(pushButton)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playerLayer.player?.play()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        playerLayer.player?.pause()
    }
    
    @objc func playAgain(notification: NSNotification) {
        let item :AVPlayerItem = notification.object as! AVPlayerItem
        item.seek(to: kCMTimeZero) { (complete) in
            self.playerLayer.player?.play()
        }
    }
    
    @objc func pushAction() {
        let col = UIViewController()
        col.view.backgroundColor = .white
        col.title = "新世界"
        self.show(col, sender: nil)
    }

    deinit {
        // 虽然iOS8后系统会帮你释放，但是手动释放会好点不是么提醒自己
        NotificationCenter.default.removeObserver(self)
        print("页面释放")
    }

}
