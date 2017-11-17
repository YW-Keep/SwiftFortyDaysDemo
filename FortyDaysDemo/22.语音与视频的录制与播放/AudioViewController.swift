//
//  AudioViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/16.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class AudioViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "音频的录制与播放"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pushToRecorder(_ sender: UIButton) {
        let col = RecorderViewController()
        self.show(col, sender: nil)
    }
    
    @IBAction func pushToVideoRecorder(_ sender: UIButton) {
        let col = VideoRecordViewController()
        self.show(col, sender: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
