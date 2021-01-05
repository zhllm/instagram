//
//  ZLScaleTransition.swift
//  instagram
//
//  Created by 张杰 on 2020/12/26.
//

import UIKit

class ZLScaleTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to),
              let from = transitionContext.viewController(forKey: .from) else {
            return
        }
        let containerView = transitionContext.containerView
        let toView = toVC.view!
        let fromView = from.view!
        
        containerView.addSubview(toView)
        containerView.addSubview(fromView)
        let duration = self.transitionDuration(using: transitionContext)
        toView.frame = CGRect(x: 0, y: 88, width: toView.width, height: toView.height)
        
        UIView.animate(withDuration: duration) {
            fromView.alpha = 0.0
            fromView.transform = CGAffineTransform(translationX: 0, y: -88) // CGAffineTransform(scaleX: 0.2, y: 0.2)
            toView.alpha = 1.0
            toView.transform = CGAffineTransform(translationX: 0, y: 88)
        } completion: { (finished) in
            fromView.transform = CGAffineTransform(scaleX: 1, y: 1)
            transitionContext.completeTransition(true)
        }
        
    }
    
    
}
