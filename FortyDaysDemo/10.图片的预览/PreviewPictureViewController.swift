//
//  PreviewPictureViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/1.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class PreviewPictureViewController: UIViewController,UIScrollViewDelegate,UIGestureRecognizerDelegate {
    
    // 记录所有变化方式
    private var rotateTransform = CGAffineTransform(rotationAngle: 0)
    private var pinchTransform = CGAffineTransform(scaleX: 1,y: 1)
    private var panTransform = CGAffineTransform(translationX: 0, y: 0)
    private var gesturesArray: [UIGestureRecognizer]!
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: (kScreenHeight - 300 - 64)/2.0, width: kScreenWidth, height: 300))
        imageView.image = #imageLiteral(resourceName: "gastronomy2.jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        // 设置代理 击穿手势 使手势同时有效 改变一个
        // 旋转手势
        var rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotateGestureAction(sender:)))
        rotateGesture.delegate = self
        imageView.addGestureRecognizer(rotateGesture)
        
        // 捏合手势
        var pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureAciton(sender:)))
        pinchGesture.delegate = self
        imageView.addGestureRecognizer(pinchGesture)
        
        // 移动手势
        var panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(sender:)))
        panGesture.delegate = self
        
        imageView.addGestureRecognizer(panGesture)
        
        imageView.isUserInteractionEnabled = true
        // 这样设置会有个小问题，一些设置的值会存在相互影响的可能性，这里就不再深入探究了，如果要效果好，用单一手势 然后做单一transform 修改 效果肯定杠杠的
        gesturesArray = [rotateGesture, pinchGesture, panGesture]
        return imageView ;
    }()
    
    lazy var backImageView: UIImageView = {
       let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        let image: UIImage = #imageLiteral(resourceName: "gastronomy2.jpg")
        imgView.contentMode = .scaleAspectFill
        imgView.layer.masksToBounds = true
        let inputImage = CIImage(cgImage: image.cgImage!)
        // 高斯模糊
        let filter = CIFilter(name: "CIGaussianBlur")!
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(10, forKey: kCIInputRadiusKey)
        let outputCIImage = filter.outputImage!
        let rect = CGRect(origin: CGPoint.zero, size: image.size)
        let cgImage = CIContext(options: nil).createCGImage(outputCIImage, from: rect)
        //显示生成的模糊图片
        imgView.image = UIImage(cgImage: cgImage!)
        return imgView;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "图片预览"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(backImageView)
        self.view.addSubview(imageView)
        // Do any additional setup after loading the view.
    }
    
    //旋转手势
    @objc func rotateGestureAction(sender: UIRotationGestureRecognizer) {
        rotateTransform = CGAffineTransform(rotationAngle: sender.rotation)
        imageView.transform = mergeTransform()
        //状态结束 返回原样
        if sender.state == UIGestureRecognizerState.ended{
            endClean()
        }
    }
    // 捏合手势
    @objc func pinchGestureAciton(sender: UIPinchGestureRecognizer) {
        pinchTransform = CGAffineTransform(scaleX: sender.scale,y: sender.scale)
        imageView.transform = mergeTransform()
        //状态是否结束，如果结束保存数据
        if sender.state == UIGestureRecognizerState.ended{
            endClean()
        }
    }
    //拖手势
    @objc func panGestureAction(sender: UIPanGestureRecognizer){
        //得到拖的过程中的xy坐标
        let translation : CGPoint = sender.translation(in: imageView)
        panTransform = CGAffineTransform(translationX: translation.x, y: translation.y)
        imageView.transform = mergeTransform()
        if sender.state == UIGestureRecognizerState.ended{
            endClean()
        }
    }
    
    // 合并手势
    func mergeTransform() -> CGAffineTransform {
        var transform = pinchTransform
        transform = transform.concatenating(rotateTransform)
        transform = transform.concatenating(panTransform)
        return transform
    }
    
    // 清空变为原样
    func endClean() {
        imageView.transform = CGAffineTransform(translationX: 0, y: 0)
        imageView.frame = CGRect(x: 0, y: (kScreenHeight - 300 - 64)/2.0, width: kScreenWidth, height: 300)
        rotateTransform = CGAffineTransform(rotationAngle: 0)
        pinchTransform = CGAffineTransform(scaleX: 1,y: 1)
        panTransform = CGAffineTransform(translationX: 0, y: 0)
    }
    
    //MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gesturesArray.contains(gestureRecognizer) && gesturesArray.contains(otherGestureRecognizer){
            return true
        }
        return false
    }
    
}
