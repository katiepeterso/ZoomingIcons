//
//  ZoomingIconTransition.swift
//  ZoomingIcons
//
//  Created by Katherine Peterson on 2015-10-01.
//  Copyright © 2015 KatieExpatriated. All rights reserved.
//

import UIKit

protocol ZoomingIconTransitionDelegate {
    
    func zoomingIconColoredViewForTransition(transition: ZoomingIconTransition) -> UIView?
    func zoomingIconImageViewForTransition(transition: ZoomingIconTransition) -> UIImageView?
}

private let kZoomingIconTransitionDuration: NSTimeInterval = 0.5

class ZoomingIconTransition: NSObject, UIViewControllerAnimatedTransitioning, UINavigationControllerDelegate {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return kZoomingIconTransitionDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(transitionContext)
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        let containerView = transitionContext.containerView()
        containerView?.addSubview(fromViewController!.view)
        containerView?.addSubview(toViewController!.view)
        
        toViewController?.view.alpha = 0
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            toViewController?.view.alpha = 1
            }) { (finished) -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is ZoomingIconTransitionDelegate &&
            toVC is ZoomingIconTransitionDelegate {
                return self
        }
        else {
            return nil
        }
    }
}
