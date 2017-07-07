//
//  FlipPresentAnimationController.swift
//  GuessThePet
//
//  Created by Zhe Jia on 7/6/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import UIKit

class FlipPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    var originalFrame = CGRect.zero
    var transitionDuration = 0.6
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to)  else {
            return
        }
        
        let initialFrame = originalFrame
        let finalFrame = transitionContext.finalFrame(for: toVC)
        
        let snapShot = toVC.view.snapshotView(afterScreenUpdates: true)
        snapShot?.frame = initialFrame
        snapShot?.layer.cornerRadius = 25
        snapShot?.layer.masksToBounds = true
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapShot!)
        toVC.view.isHidden = true
        
        AnimationHelper.perspectiveTransformForContainerView(containerView)
        snapShot?.layer.transform = AnimationHelper.yRotation(.pi/2)
        
        UIView.animateKeyframes(withDuration: transitionDuration, delay: 0, options: [.calculationModeCubic], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3, animations: {
                fromVC.view.layer.transform = AnimationHelper.yRotation(-.pi/2)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3, animations: {
                snapShot?.layer.transform = AnimationHelper.yRotation(0.0)
            })
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
                snapShot?.frame = finalFrame
            })
        }) { (_) in
            toVC.view.isHidden = false
            fromVC.view.layer.transform = AnimationHelper.yRotation(0.0)
            snapShot?.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
