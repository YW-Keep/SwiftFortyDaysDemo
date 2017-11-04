//
//  PositionAnimationViewController.swift
//  FortyDaysDemo
//
//  Created by 唐余威 on 2017/11/4.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class PositionAnimationViewController: UIViewController {
    var num: Int = 0
    var isCycle: Bool = true
     lazy var changeView: UIView = {
        let inView = UIView(frame: CGRect(x: 0, y: 64, width: 40, height: 40))
        inView.backgroundColor = UIColor.lightGray
        inView.layer.cornerRadius = 20
        inView.layer.masksToBounds = true
        return inView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "基础动画"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(changeView)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.positionAnimation()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.isCycle = false
    }
    
    func positionAnimation() {
        // 基础动画套路都一样 在 animations 里改变值 可以修改颜色 alpha, 大小，位置，transform（这里的值包括旋转） 这里就不一一举例了 当然还可以这是spring动画。
        UIView.animate(withDuration: 0.5, animations: {
            self.changeView.frame.origin = self.getRandomPoint()
        }) { (completion) in
            if self.isCycle {
                self.positionAnimation()
            }
        }
    }
    
    // 获得坐标随机数
    func getRandomPoint() -> CGPoint {
        let xNum = arc4random_uniform(UInt32(kScreenWidth - 40))
        let yNum = arc4random_uniform((UInt32(kScreenHeight - 104)))
        var point = CGPoint(x: Int(xNum), y: Int(yNum + 64))
        num += 1
        num = num % 4
        switch num {
        case 0:
            point.y = 64
        case 1:
            point.x = 0
        case 2:
            point.y = kScreenHeight - 40
        case 3:
            point.x = kScreenWidth - 40
        default: break
        }
        return point
    }
    
    deinit {
        print("页面释放")
    }
}
