//
//  DrawersBaseViewControntroller.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/27.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class DrawersBaseViewControntroller: UIViewController {
    var mainCol: UINavigationController
    var leftCol: UIViewController
    
    lazy var layerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        view.backgroundColor = .black
        view.alpha = 0
        view.isHidden = true
        return view
    }()
    
    init(mainController: UINavigationController,leftController: UIViewController) {
        mainCol = mainController
        leftCol = leftController
        super.init(nibName: nil, bundle: nil)
        
        // 这里用了一个极端偷懒的方式  大家不要学 哈哈
        (leftCol as? DrawersLeftViewController)?.mainCol = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(mainController: UINavigationController(), leftController: UIViewController())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 添加左滑视图 和主视图
        self.view.backgroundColor = .white
        self.addChildViewController(leftCol)
        self.view.addSubview(leftCol.view)
        self.addChildViewController(mainCol)
        self.view.addSubview(mainCol.view)
        
        //增加滑动手势
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.panAction(sender:)))
        self.mainCol.viewControllers[0].view.addGestureRecognizer(pan)
     
        // 增加蒙层
        self.mainCol.view.addSubview(layerView)
        let pan2 = UIPanGestureRecognizer(target: self, action: #selector(self.panAction(sender:)))
        layerView.addGestureRecognizer(pan2)
        // 这是单击返回手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapAction))
        layerView.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    @objc private func panAction(sender: UIPanGestureRecognizer){
        if sender.state == .began {
            layerView.isHidden = false
        }
        if(mainCol.view!.frame.origin.x >= 0) {
            let point = sender.translation(in: sender.view)
            var num = (mainCol.view?.center.x)! + point.x
            num = num > self.view.center.x ? num : self.view.center.x
            num = num < self.view.center.x * 2.5 ? num : self.view.center.x * 2.5
            
            //修改主View的偏移量
            mainCol.view?.center = CGPoint(x: num, y: (mainCol.view?.center.y)!)
                
            // 修改蒙层的透明度
            let coefficient = (num - self.view.center.x) / (self.view.center.x * 1.5)
            layerView.alpha = 0.3*coefficient
            
            //矫正手指位置
            sender.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
        }
      
        if sender.state == .ended {
            UIView.animate(withDuration: 0.3, animations: {
                var num: CGFloat = 0
                var alpha: CGFloat = 0
                if self.mainCol.view!.frame.origin.x >=  kScreenWidth*0.4{
                    num = self.view.center.x * 2.5
                    alpha = 0.3
                } else {
                    num = self.view.center.x
                    alpha = 0
                }
                self.mainCol.view?.center = CGPoint(x: num, y: (self.mainCol.view?.center.y)!)
                self.layerView.alpha = alpha
            }, completion: { (_) in
                self.layerView.isHidden = self.layerView.alpha == 0
            })
        }
    }
    
    @objc func tapAction(){
        UIView.animate(withDuration: 0.3, animations: {
            self.mainCol.view?.center = CGPoint(x: self.view.center.x, y: (self.mainCol.view?.center.y)!)
            self.layerView.alpha = 0
        }, completion: { (_) in
            self.layerView.isHidden = true
        })
    }
    
    // preferredStatusBarStyle 这个会被根视图拦截 
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return mainCol.preferredStatusBarStyle
    }
}
