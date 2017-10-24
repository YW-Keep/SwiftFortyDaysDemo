//
//  ColorGradientViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/10/24.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class ColorGradientViewController: UIViewController {
    let layer = CAGradientLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "颜色渐变"
      
        layer.frame = self.view.frame
        layer.colors = [UIColor.red.cgColor,UIColor.green.cgColor,UIColor.blue.cgColor,UIColor.red.cgColor,UIColor.green.cgColor]
        layer.locations = [0,0.25,0.5,0.75,1]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        self.view.layer.addSublayer(layer)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.becomeFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.resignFirstResponder()
    }
    
    // 摇动变色
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.type == UIEventType.motion {
            layer.colors = [getRandomColor(),getRandomColor(),getRandomColor(),getRandomColor(),getRandomColor()]
        }
    }
    // 获取随机颜色
    func getRandomColor() -> CGColor {
        func getRandomNum() ->CGFloat {
            let num = arc4random_uniform(256)
            return (CGFloat(num)/255.0)
        }
        return UIColor.init(red: getRandomNum(), green: getRandomNum(), blue: getRandomNum(), alpha: 1).cgColor
    }
}
