//
//  PopAnimation.swift
//  BeginnerCook
//
//  Created by George Jia on 7/5/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import UIKit

class PopAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 1.0
    var presenting = true
    var originalFrame = CGRect.zero
    var dismissCompletion: (() -> Void)?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)
        
        var herbView: UIView
        var initialFrame: CGRect
        var finalFrame: CGRect
        var xScaleFactor: CGFloat
        var yScaleFactor: CGFloat
        if presenting {
            herbView = toView!
            initialFrame = originalFrame
            finalFrame = herbView.frame
            xScaleFactor = initialFrame.width / finalFrame.width
            yScaleFactor = initialFrame.height / finalFrame.height
        }
        else {
            herbView = transitionContext.view(forKey: .from)!
            initialFrame = herbView.frame
            finalFrame = originalFrame
            xScaleFactor = finalFrame.width / initialFrame.width
            yScaleFactor = finalFrame.height / initialFrame.height
        }
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        if presenting {
            herbView.transform = scaleTransform
            herbView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
            herbView.clipsToBounds = true
        }
        
        containerView.addSubview(toView!)
        containerView.bringSubview(toFront: herbView)
        
        if !self.presenting,
            let herbViewController = transitionContext.viewController(forKey: .from) as? HerbDetailsViewController {
            herbViewController.descriptionView.isHidden = true
            herbViewController.titleView.isHidden = true
        }
        
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: [], animations: { 
            herbView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
            herbView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            herbView.layer.cornerRadius = self.presenting ? 0.0 : 40.0

        }) { (_) in
            
            if !self.presenting {
                self.dismissCompletion?()
            }
            
            transitionContext.completeTransition(true)
        }
    }
    

}
