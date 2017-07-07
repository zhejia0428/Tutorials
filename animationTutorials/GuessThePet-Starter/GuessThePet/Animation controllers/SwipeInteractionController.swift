//
//  SwipeInteractionController.swift
//  GuessThePet
//
//  Created by Zhe Jia on 7/6/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import UIKit

class SwipeInteractionController: UIPercentDrivenInteractiveTransition {
    var interactionInProgress = false
    fileprivate var shouldCompleteTransition = false
    fileprivate weak var viewController: UIViewController!
    
    func wireToViewController(_ viewController: UIViewController!) {
        self.viewController = viewController
        self.prepareGestureRecognizerInView(self.viewController.view)
    }
    
    private func prepareGestureRecognizerInView(_ view: UIView) {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        gesture.edges = UIRectEdge.left
        view.addGestureRecognizer(gesture)
    }
    
    func handleGesture(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        var progress = translation.x/200
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        
        
        switch gestureRecognizer.state {
        case .began:
            interactionInProgress = true
            viewController.dismiss(animated: true, completion: nil)
        case .changed:
            shouldCompleteTransition = progress > 0.5
            self.update(progress)
        case .cancelled:
            interactionInProgress = false
            self.cancel()
        case .ended:
            interactionInProgress = false
            
            if !shouldCompleteTransition {
                self.cancel()
            }
            else {
                self.finish()
            }
        
        default:
            interactionInProgress = false
            self.cancel()
        }
        
    }
}
