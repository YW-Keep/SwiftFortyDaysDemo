//
//  VideoPlayViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/16.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class VideoPlayViewController: UIViewController, RecorderManagerDeleagte {
    
    var name: String?
    
    let recorderManager = RecorderManager()
    
    @IBOutlet weak var playButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        recorderManager.delegate = self
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func palyAction(_ sender: UIButton) {
        if name != nil {
            if !sender.isSelected {
                recorderManager.play(name: name!)
                
            } else {
                recorderManager.pausePlay()
            }
            sender.isSelected = !sender.isSelected
        }
    }
    @IBAction func stopAction(_ sender: UIButton) {
        recorderManager.stopPlay()
        playButton.isSelected = false
    }
    
    func endPlay() {
        palyAction(playButton)
    }
    
    deinit {
        print("页面释放")
    }
}
