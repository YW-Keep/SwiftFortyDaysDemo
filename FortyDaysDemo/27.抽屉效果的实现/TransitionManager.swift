//
//  TransitionManager.swift
//  FortyDaysDemo
//
//  Created by Lotheve on 2017/11/28.
//  Copyright © 2017年 Tang. All rights reserved.
//

import UIKit

 @objc protocol TransitionManagerDelegate {
    func dismiss()
}

class TransitionManager: NSObject,UIViewControllerTransitioningDelegate {
    var isPresenting = false
    var snapshot:UIView? {
        didSet {
            if delegate != nil {
                let tapGestureRecognizer = UITapGestureRecognizer(target: delegate, action: #selector(delegate?.dismiss))
                snapshot?.addGestureRecognizer(tapGestureRecognizer)
            }
        }
    }
    
    weak var delegate:TransitionManagerDelegate?
    
    // 会先询问是否返回了一个遵守了UIViewControllerAnimatedTransitioning协议的对象，如果为空则调用系统默认的动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    // 返回时候的是否代理动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
 
    
}
extension TransitionManager: UIViewControllerAnimatedTransitioning {
    // 动画时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    // 执行动画的地方
    func animateTransition(using transitionContext:
        UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from), let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else{
            return
        }
        let fromView = fromVC.view!
        let toView = toVC.view!
        
        let container = transitionContext.containerView
        let moveDown = CGAffineTransform(translationX: 0, y: container.frame.height - 150)
        let moveUp = CGAffineTransform(translationX: 0, y: -50)
        
        if isPresenting {
            toView.transform = moveUp
            snapshot = fromView.snapshotView(afterScreenUpdates: true)
            container.addSubview(toView)
            container.addSubview(snapshot!)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            
            if self.isPresenting {
                self.snapshot?.transform = moveDown
                toView.transform = CGAffineTransform.identity
            } else {
                self.snapshot?.transform = .identity
                fromView.transform = moveUp
            }
            
        }, completion: { finished in
            
            transitionContext.completeTransition(true)
            if !self.isPresenting {
                self.snapshot?.removeFromSuperview()
            }
        })
        
    }
    // 动画结束后
    func animationEnded(_ transitionCompleted: Bool) {
        
    }
}
