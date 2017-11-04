//
//  CoreAnimationViewController.swift
//  FortyDaysDemo
//
//  Created by 唐余威 on 2017/11/4.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit
/* 核心动画 - CAnimation Core Animation
 主要使用步骤
 1.创建CAAnimation 对象并且赋所需要的值
 2.把动画添加到对象的Layer层从而完成动画，可以通过remove方法移除
 */
class CoreAnimationViewController: UIViewController {

    lazy var translationView: UIView = {
       let inView =  UIView(frame: CGRect(x: 20, y: 100, width: 40, height: 40))
        inView.backgroundColor = UIColor.lightGray
        
        // 平移动画（中心点改变）
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.toValue = 300
        animation.duration = 2
        // 是否执行逆动画
        animation.autoreverses = true
        // 不断重复复
        animation.repeatCount = Float.infinity
        inView.layer.add(animation, forKey: "postion")
        
        return inView
    }()
    
    // 旋转
    lazy var rotationView: UIView = {
        let inView =  UIView(frame: CGRect(x: 0, y: 150, width: kScreenWidth, height: 60))
        
        // x 轴旋转
        let rotationX = UIView(frame: CGRect(x: 40, y: 10, width: 40, height: 40))
        rotationX.backgroundColor = UIColor.lightGray
        
        var animation = CABasicAnimation(keyPath: "transform.rotation.x")
        animation.toValue = 2 * Double.pi
        animation.duration = 2
        animation.repeatCount = Float.infinity
        
        rotationX.layer.add(animation, forKey: "rotation.x")
        inView.addSubview(rotationX)
        
        // y 轴旋转
        let rotationY = UIView(frame: CGRect(x: 120, y: 10, width: 40, height: 40))
        rotationY.backgroundColor = UIColor.lightGray
        
        animation = CABasicAnimation(keyPath: "transform.rotation.y")
        animation.toValue = 2 * Double.pi
        animation.duration = 2
        animation.repeatCount = Float.infinity
        
        rotationY.layer.add(animation, forKey: "rotation.y")
        inView.addSubview(rotationY)
        
        // z 轴旋转
        let rotationZ = UIView(frame: CGRect(x: 200, y: 10, width: 40, height: 40))
        rotationZ.backgroundColor = UIColor.lightGray
        
        animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = 2 * Double.pi
        animation.duration = 2
        animation.repeatCount = Float.infinity
        
        rotationZ.layer.add(animation, forKey: "rotation.z")
        inView.addSubview(rotationZ)

        return inView
    }()
    
    lazy var colorView: UIView = {
        let inView =  UIView(frame: CGRect(x: 100, y: 220, width: 40, height: 40))
        inView.backgroundColor = UIColor.yellow
        
        // 颜色变换
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.toValue = UIColor.red.cgColor
        animation.duration = 2
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        inView.layer.add(animation, forKey: "backgroundColor")
        
        return inView
    }()
    
    lazy var opacityView: UIView = {
        let inView =  UIView(frame: CGRect(x: 150, y: 220, width: 40, height: 40))
        inView.backgroundColor = UIColor.lightGray
        
        // 透明度 (闪烁)
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.toValue = 0.1
        animation.duration = 0.2
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        inView.layer.add(animation, forKey: "opacity")
        
        return inView
    }()
    
    lazy var roundedView: UIView = {
        let inView =  UIView(frame: CGRect(x: 200, y: 220, width: 40, height: 40))
        inView.backgroundColor = UIColor.lightGray
        
        // 圆角动画
        let animation = CABasicAnimation(keyPath: "cornerRadius")
        animation.toValue = 20
        animation.duration = 2
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        inView.layer.add(animation, forKey: "cornerRadius")
        
        return inView
    }()
    //  当然 单个的动画 还有很多 比如照片变换 contents 还有 bounds  还有横向纵向拉伸contentsRect.size  这里就不在一一列举了
    
    /*
     接下来是针动画CAKeyframeAnimation 就是制定一串值进行动画
     主要的属性是：
     values：是许多值组成的数组用来进行动画的。这个属性比较特别，只有在path属性值为nil的时候才有作用
     path：路径,可以指定一个路径,让动画沿着这个指定的路径执行。
     cacluationMode：计算模式。其主要针对的是每一帧的内容为一个座标点的情况,也就是对anchorPoint 和 position 进行的动。当在平面座标系中有多个离散的点的时候，可以是离散的，也可以直线相连后进行插值计算，也可以使用圆滑的曲线将他们相连后进行插值计算。
    */
    
    // 抖动的效果 (其实也可以加返回动画完成 这里只是为了试验下 哈哈)
    lazy var shakingView: UIView = {
        let inView =  UIView(frame: CGRect(x: 280, y: 220, width: 40, height: 40))
        inView.backgroundColor = UIColor.lightGray
        
        // 圆角动画
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        animation.values = [Double.pi * -0.1, Double.pi * 0.1, Double.pi * -0.1]
        animation.duration = 0.2
        animation.repeatCount = Float.infinity
        inView.layer.add(animation, forKey: "cornerRadius")
        
        return inView
    }()
    
    // 通过贝塞尔曲线完成曲线移动 先写出贝塞尔曲线，然后再通过CAShapeLayer画再view层上另外一个视图再该线上移动
    // ps 这里可以做圆形精度条了 哈哈 可以加个定时器 是不是也是个动画 
    lazy var shakeView: UIView = {
        let inView =  UIView(frame: CGRect(x: 50, y:300, width: 100, height: 100))
        inView.backgroundColor = UIColor.white
        
        let radius: CGFloat = 50.0
        let startAngle: CGFloat = 0.0
        let endAngle: CGFloat = CGFloat(Double.pi * 2)
        let path = UIBezierPath(arcCenter: CGPoint(x: 50, y: 50), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.black.cgColor
        inView.layer.addSublayer(layer)
        
        let smallView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        smallView.backgroundColor = UIColor.blue
        smallView.layer.cornerRadius = 5
        smallView.layer.masksToBounds = true
        // 圆角动画
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.cgPath
        animation.duration = 2
        animation.repeatCount = Float.infinity
        
        inView.addSubview(smallView)
        smallView.center = CGPoint(x: 50, y: 0)
        smallView.layer.add(animation, forKey: "position-two")
        
        return inView
    }()
    // 最有有个动画组CAAnimationGroup   用法类似就不写了
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "核心动画"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(translationView)
        self.view.addSubview(rotationView)
        self.view.addSubview(colorView)
        self.view.addSubview(opacityView)
        self.view.addSubview(roundedView)
        self.view.addSubview(shakingView)
        self.view.addSubview(shakeView);
        // Do any additional setup after loading the view.
    }
    
    deinit {
        print("页面释放")
    }

}
