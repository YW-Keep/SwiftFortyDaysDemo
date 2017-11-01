//
//  PreviewPictureViewController.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/1.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

class PreviewPictureViewController: UIViewController,UIScrollViewDelegate,UIGestureRecognizerDelegate {
    var  multiple: CGFloat = 1
    
    var isFirst: Bool = true
    var rotationRem: CGFloat = 0
    var point: CGPoint = CGPoint(x: 0, y: 0)
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
        return imageView ;
    }()
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64))
        scroll.addSubview(imageView)
        scroll.backgroundColor  = UIColor.yellow
        scroll.maximumZoomScale = 3.0
        scroll.minimumZoomScale = 0.5
        scroll.delegate = self
        return scroll
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
        //浮点类型，得到sender的旋转度数
        let rotation : CGFloat =  sender.rotation - rotationRem
        rotationRem = sender.rotation
        //旋转角度CGAffineTransformMakeRotation,改变图像角度
        imageView.transform = imageView.transform.rotated(by:rotation)
        //状态结束 返回原样
        if sender.state == UIGestureRecognizerState.ended{
            imageView.transform = CGAffineTransform(rotationAngle: 0)
            imageView.frame = CGRect(x: 0, y: (kScreenHeight - 300 - 64)/2.0, width: kScreenWidth, height: 300)
        }
    }
    // 捏合手势
    @objc func pinchGestureAciton(sender: UIPinchGestureRecognizer) {
       
        let factor = sender.scale/multiple
         multiple = sender.scale
        imageView.transform = imageView.transform.scaledBy(x: factor, y: factor)
       
        //状态是否结束，如果结束保存数据
        if sender.state == UIGestureRecognizerState.ended{
            imageView.transform = CGAffineTransform(scaleX: 1,y: 1)
            imageView.frame = CGRect(x: 0, y: (kScreenHeight - 300 - 64)/2.0, width: kScreenWidth, height: 300)
        }
    }
    //拖手势
    @objc func panGestureAction(sender: UIPanGestureRecognizer){
        //得到拖的过程中的xy坐标
        let translation : CGPoint = sender.translation(in: imageView)
        //平移图片CGAffineTransformMakeTranslation
        let ponitX = translation.x - point.x
        let pointY = translation.y - point.y
        point = translation
        imageView.transform = imageView.transform.translatedBy(x: ponitX, y: pointY)
        
        if sender.state == UIGestureRecognizerState.ended{
            imageView.transform = CGAffineTransform(translationX: 0, y: 0)
            imageView.frame = CGRect(x: 0, y: (kScreenHeight - 300 - 64)/2.0, width: kScreenWidth, height: 300)
        }
    }
    
    //MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    //MARK: - UIScrollViewDelegate
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//        print(scrollView.zoomScale)
        // 居中显示
        let offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width) ? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
        let offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height) ?
            (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
        imageView.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX, y: scrollView.contentSize.height * 0.5 + offsetY)
//        imageView.frame.size.height = 300 * scrollView.zoomScale
//        imageView.frame.size.width = kScreenWidth * scrollView.zoomScale
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
