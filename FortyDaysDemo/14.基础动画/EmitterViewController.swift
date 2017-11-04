//
//  EmitterViewController.swift
//  FortyDaysDemo
//
//  Created by 唐余威 on 2017/11/4.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit
/*
 iOS中实现粒子特效 主要是CAEmitterLayer，他是Layer层的子类
 主要属性如下：
 发射器属性
 emitterShape      发射器形状，有点 线立方体 圆形，球行
 emitterMode       发射器发射模式 有中心，边缘，表面等
 emitterSize       发射器尺寸
 emitterPosition   发射器的中心位置
 emitterZPosition  发射器Z平面位置
 粒子属性
 birthRate         粒子创建速率
 lifetime          粒子存在时间
 lifetimeRange     粒子存在的时间容差
 emissionLatitude  发射在Z轴方向的发射角度
 emissionLongitude 在xy平面的角度
 emissionRange     角度容差
 velocityRange     粒子速度容差
 contents          渲染粒子 可以为图片
 contentsRect      渲染范围
 */



class EmitterViewController: UIViewController {
    
    // 雪花 同理可以做烟花等
    lazy var snowView: UIView = {
        let inView =  UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        inView.backgroundColor = UIColor.white
        
        // 发射器配置
        let emitterLayer = CAEmitterLayer()
        emitterLayer.frame = CGRect(x: 0, y: 0, width: inView.bounds.size.width, height: kScreenHeight)
        emitterLayer.emitterSize = CGSize(width: inView.bounds.size.width, height: 0)
        emitterLayer.emitterPosition = CGPoint(x: inView.bounds.size.width / 2, y: -40)
        emitterLayer.masksToBounds = true
        emitterLayer.emitterShape = kCAEmitterLayerLine
        emitterLayer.emitterMode = kCAEmitterLayerSurface
        
        inView.layer.addSublayer(emitterLayer)
        
        // 粒子配置
        let cell = CAEmitterCell()
        cell.birthRate = 1
        cell.speed = 10
        cell.velocity = 2
        cell.velocityRange = 10
        cell.yAcceleration = 10
        cell.emissionRange = CGFloat(0.5 * Double.pi)
        cell.spinRange = CGFloat(0.25 * Double.pi)
        cell.contents = UIImage(named: "snow")?.cgImage
        cell.contentsRect = CGRect(x: 0, y: 0, width: 10, height: 10)
        cell.lifetime = 180
        cell.scale = 0.5
        cell.scaleRange = 0.3
        emitterLayer.emitterCells = [cell]
        
    
        
        return inView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "粒子动画"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(snowView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("页面释放")
    }

}
