//
//  TouchShowViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/10/25.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class TouchShowViewController: UIViewController {
    // 重写previewActionItems的get 方法 完成  3D Touch 的上滑的按钮
    override var previewActionItems: [UIPreviewActionItem] {
        let action1 = UIPreviewAction(title: "快来分享呀", style: .selected, handler: { action, viewController in
            print("快来分享呀")
        })
        let action2 = UIPreviewAction(title: "取消啦", style: .destructive, handler: { action, viewController in
            print("取消")
        })
        let action3 = UIPreviewActionGroup(title: "更多", style: .default, actions: [action1, action2])
        return [action1,action3,action2]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
