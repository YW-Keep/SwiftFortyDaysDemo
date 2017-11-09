//
//  ScreenSwitchViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/9.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class ScreenSwitchViewController: UIViewController {

    @IBOutlet weak var contentImgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "横竖屏切换"
        contentImgView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
