//
//  HalfWaySpringAnimator.swift
//  instagram
//
//  Created by 张杰 on 2020/12/27.
//

import UIKit

enum PresentType {
    case prsent
    case dismis
}

typealias VoidFunction = () -> ()

class HalfWaySpringAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private var currentType: PresentType?
    
    private var completed: VoidFunction?
    
    init(type: PresentType, completed: VoidFunction?) {
        self.currentType = type
    }
    
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(
        using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        let containerView = transitionContext.containerView
        
        guard let fromView = fromVC?.view, let toView = toVC?.view else {
            print("toVC is nil")
            return
        }
        //        if transitionContext.responds(to: Selector("viewForKey:")) {
        //            fromView = transitionContext.view(forKey: .from)
        //            toView = transitionContext.view(forKey: .to)
        //        }
        let transitionDuration = self.transitionDuration(using: transitionContext)
        let currentType = self.currentType
        let transformFram = CGRect(
            x: fromView.frame.origin.x,
            y: 88,
            width: fromView.frame.width,
            height: fromView.frame.height
        )
        if currentType == .prsent {
            containerView.addSubview(toView)
            toView.frame = transformFram
            toView.alpha = 0.0
            if self.completed != nil {
                self.completed!()
            }
            UIView.animate(withDuration: transitionDuration) {
                toView.alpha = 1.0
                toView.frame = transitionContext.finalFrame(for: toVC!)
            } completion: { (finished) in
                transitionContext.completeTransition(true)
            }
        } else {
            containerView.addSubview(toView)
            containerView.insertSubview(toView, at: 0)
            toView.frame = CGRect(x: fromView.frame.origin.x, y: 0, width: fromView.frame.width, height: fromView.frame.height)
            UIView.animate(withDuration: transitionDuration) {
                fromView.alpha = 0
                fromView.frame = transformFram
            } completion: { [weak self] (completed) in
                if completed {
                    fromView.removeFromSuperview()
                }
                transitionContext.completeTransition(true)
                guard let weakSelf = self, let callback = weakSelf.completed else {
                    return
                }
                callback()
            }
        }
    }
}
