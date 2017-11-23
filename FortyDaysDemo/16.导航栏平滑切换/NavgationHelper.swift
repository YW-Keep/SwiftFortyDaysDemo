//
//  NavgationHelper.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/7.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

extension UIViewController {
    // 分类不能扩展储存的属性
    // 静态的结构体，用来保存属性
    fileprivate struct AssociatedKeys {
        static var navBarBgAlpha: CGFloat = 1.0
        static var navBarTintColor: UIColor = UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1.0)
    }
    // 绑定Alpha
    open var navBarAlpha: CGFloat {
        
        get {
            // 守护  即要保证 判断内容 否则执行括号内东西
            guard let alpha = objc_getAssociatedObject(self, &AssociatedKeys.navBarBgAlpha) as? CGFloat else {
                  return 1.0
            }
            return alpha
        }
        
        set {
            // newValue 就是设置的值
            let alpha = newValue
            objc_setAssociatedObject(self, &AssociatedKeys.navBarBgAlpha, alpha, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            // 更新 alpha
            navigationController?.changeNavigationBackground(alpha: alpha)
        }
    }
    
    // 绑定 TintColor
    open var navBarTintColor: UIColor {
        get {
            guard let tintColor = objc_getAssociatedObject(self, &AssociatedKeys.navBarTintColor) as? UIColor else {
                // 返回系统颜色
                return UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1.0)
            }
            return tintColor
            
        }
        set {
            navigationController?.navigationBar.tintColor = newValue
            objc_setAssociatedObject(self, &AssociatedKeys.navBarTintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

/*
 因为导航栏上的NavigationBarItem是需要保留下来的，所以不能设置整个导航栏的透明度
 UINavigationBar  下面2层
 一层   UIBarBackground
 UIBarBackground 又有两层
 UIImageView(设置图片了)
 UIVisualEffectView
 UIVisualEffectBackdropView
 UIVisualEffectSubview
 一层UINavigationBarContentView
*/
extension UINavigationController {
    
    //Some other code
    open override func viewDidLoad() {
        UINavigationController.swizzle()
        super.viewDidLoad()        
    }
    
    //  NavigationController 会拦截状态栏，所以需要获取topView做一个调用
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    
    
     private static let onceToken = UUID().uuidString
    
    //method swizzling 两个方法
    class func swizzle() {
        
        guard self == UINavigationController.self else { return }
        // 保证方法交换只执行一次
        DispatchQueue.once(token: onceToken) {
            let needSwizzleSelectorArr = [
                NSSelectorFromString("_updateInteractiveTransition:")
            ]
            
            for selector in needSwizzleSelectorArr {
                
                //            let str = ("et_" + selector.description).replacingOccurrences(of: "__", with: "_")
                // popToRootViewControllerAnimated: et_popToRootViewControllerAnimated:
                
                let originalMethod = class_getInstanceMethod(self, selector)
                let swizzledMethod = class_getInstanceMethod(self, #selector(et_updateInteractiveTransition(percentComplete:)))
                method_exchangeImplementations(originalMethod!, swizzledMethod!)
            }
        }
    }
    
    // 设置透明度
    @objc func et_updateInteractiveTransition(percentComplete: CGFloat) {
        et_updateInteractiveTransition(percentComplete: percentComplete)
        let topVC = self.topViewController
        if topVC != nil {
            //transitionCoordinator带有两个VC的转场上下文
            let coor = topVC?.transitionCoordinator
            if coor != nil {
                //fromVC 的导航栏透明度
                let fromAlpha = coor?.viewController(forKey: .from)?.navBarAlpha
                //toVC 的导航栏透明度
                let toAlpha = coor?.viewController(forKey: .to)?.navBarAlpha
                //计算当前的导航栏透明度
                let nowAlpha = fromAlpha! + (toAlpha!-fromAlpha!)*percentComplete
                //设置导航栏透明度
                self.changeNavigationBackground(alpha: nowAlpha)
            }
        }
        
    }
    
    fileprivate func changeNavigationBackground(alpha:CGFloat) {
        let barBackgroundView = navigationBar.subviews[0]
        let backgroundImageView = barBackgroundView.value(forKey: "_backgroundImageView") as? UIImageView
        // 判断是不是半透明 不是直接修改背景的
        if navigationBar.isTranslucent {
            if backgroundImageView != nil && backgroundImageView!.image != nil {
                barBackgroundView.alpha = alpha
            }else{
                if let backgroundEffectView = barBackgroundView.value(forKey: "_backgroundEffectView") as? UIView {
                    backgroundEffectView.alpha = alpha
                }
            }
        }else{
            barBackgroundView.alpha = alpha
        }
        // 修改有阴影图层的alpha
        if let shadowView = barBackgroundView.value(forKey: "_shadowView") as? UIView {
            shadowView.alpha = alpha
            shadowView.isHidden = alpha == 0
        }
        
    }
}

//ET_NavBarTransparent.swift

extension UINavigationController:UINavigationBarDelegate {

    // 点击返回以及滑动结束时候监听
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        // 这里表示滑动结束
        if let topVC = topViewController, let coor = topVC.transitionCoordinator, coor.initiallyInteractive {
            if #available(iOS 10.0, *) {
                coor.notifyWhenInteractionChanges({ (context) in
                    self.dealInteractionChanges(context)
                })
            } else {
                coor.notifyWhenInteractionEnds({ (context) in
                    self.dealInteractionChanges(context)
                })
            }
            return true
        }
        
        // 点击返回
        let itemCount = navigationBar.items?.count ?? 0
        let n = viewControllers.count >= itemCount ? 2 : 1
        let popToVC = viewControllers[viewControllers.count - n]
        changeNavigationBackground(alpha: popToVC.navBarAlpha)
        popToViewController(popToVC, animated: true)
        return true
    }
    
    // 点击push 到新页面的的情况
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool {
        changeNavigationBackground(alpha: (topViewController?.navBarAlpha)!)
        navigationBar.tintColor = topViewController?.navBarTintColor
        return true
    }
    
    //处理返回手势中断对情况
    private func dealInteractionChanges(_ context:UIViewControllerTransitionCoordinatorContext) {
        if context.isCancelled {
            //自动取消了返回手势
            let cancellDuration:TimeInterval = context.transitionDuration * Double( context.percentComplete)
            UIView.animate(withDuration: cancellDuration, animations: {
                
                let nowAlpha = (context.viewController(forKey: .from)?.navBarAlpha)!
                self.changeNavigationBackground(alpha: nowAlpha)
                self.navigationBar.tintColor = context.viewController(forKey: .from)?.navBarTintColor
            })
        }else{
            //自动完成了返回手势
            let finishDuration:TimeInterval = context.transitionDuration * Double(1 - context.percentComplete)
            UIView.animate(withDuration: finishDuration, animations: {
                let nowAlpha = (context.viewController(forKey: .to)?.navBarAlpha)!
                self.changeNavigationBackground(alpha: nowAlpha)
                self.navigationBar.tintColor = context.viewController(forKey: .to)?.navBarTintColor
            })
        }
    }
    
}

// 自定义只执行一次的代码
extension DispatchQueue {
    
    private static var onceTracker = [String]()
    
    public class func once(token: String, block: () -> Void) {
        // 这是互斥锁保证线程安全
        objc_sync_enter(self)
        // 这里用了延迟调用来保证这整个括号内的代码线程安全
        defer { objc_sync_exit(self) }
        
        if onceTracker.contains(token) {
            return
        }
        
        onceTracker.append(token)
        block()
    }
}

