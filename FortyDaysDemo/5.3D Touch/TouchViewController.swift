//
//  3DTouchViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/10/25.
//  Copyright © 2017年 Tang. All rights reserved.
//
/*
 3D Touch 主要有三大模块
 1.Home Screen Quick Actions
 主要就是通过主屏的icon，呼出快捷菜单栏
 这有两种实现方式：
  （1）静态配置，在plist文件里加载数组。
  （2）动态添加 代码在下面。
 
 2.peek and pop
 ViewController 中会有三个阶段
 （1）提示用户这里有3D Touch的交互，会使交互控件周围模糊
 （2）继续深按，会出现预览视图
 （3）通过视图上的交互控件进行进一步交互
 3.Force Properties
 力度按压
 iOS9为我们提供了一个新的交互参数:力度。
 我们可以检测某一交互的力度值，来做相应的交互处理。
 例如，我们可以通过力度来控制快进的快慢，音量增加的快慢等。
 
 */
import UIKit

// Force Properties 压力感应的View 力度按压变大变小
class PressureView: UIView {
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var multiple: CGFloat = 0.0
        if let force = touches.first?.force, let maximumPossibleForce = touches.first?.maximumPossibleForce {
            multiple = force / maximumPossibleForce
        }
   
        self.transform = CGAffineTransform(scaleX: 1 + multiple, y: 1 + multiple)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.transform = CGAffineTransform(scaleX: 1 , y: 1 )
    }
}

class TouchViewController: UIViewController,UIViewControllerPreviewingDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        // 动态添加Home Screen Quick Actions
        self.view.backgroundColor = UIColor.white
        self.title = "3D Touch"
        let addItem = UIApplicationShortcutItem(type: "one", localizedTitle: "添加", localizedSubtitle: "点击添加一个神奇的东西", icon: UIApplicationShortcutIcon.init(type: UIApplicationShortcutIconType.add), userInfo: nil)
        let shareItem = UIApplicationShortcutItem(type:"two", localizedTitle: "分享", localizedSubtitle: "点击向朋友分享", icon: UIApplicationShortcutIcon(type: UIApplicationShortcutIconType.share), userInfo: nil)
        UIApplication.shared.shortcutItems = [addItem, shareItem];
        
        
        let fistView = UIView(frame: CGRect(x: 150, y: 150, width: 100, height: 100))
        fistView.backgroundColor = UIColor.yellow
        self.view.addSubview(fistView)
        
        let secondView = PressureView(frame: CGRect(x: 150, y: 350, width: 100, height: 100))
        secondView.backgroundColor = UIColor.blue
        self.view.addSubview(secondView)
        
        //peek and pop 判断3D Touch是否可用
        if self.traitCollection.forceTouchCapability == .available {
            self.registerForPreviewing(with: self, sourceView: fistView)
        } else {
            print("3D Touch 不可用!")
        }
        
    }
    // MARK: - UIViewControllerPreviewingDelegate
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        // 这里是返回预览的col  可以通过location 定位从而完成
        let col = TouchShowViewController()
        return col
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        //这里是预览后再重按的操作处理
        self.show(viewControllerToCommit, sender: self)
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
