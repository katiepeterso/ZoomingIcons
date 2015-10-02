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
private let kZoomingIconTransitionZoomedScale: CGFloat = 15
private let kZoomingIconTransitionBackgroundScale: CGFloat = 0.80

enum TransitionState {
    case Initial
    case Final
}

typealias ZoomingViews = (coloredView: UIView, imageView: UIView)

class ZoomingIconTransition: NSObject, UIViewControllerAnimatedTransitioning, UINavigationControllerDelegate {
    
    var operation: UINavigationControllerOperation = .None
    
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
        
        var backgroundViewController = fromViewController
        var foregroundViewController = toViewController
        
        if operation == .Pop {
            backgroundViewController = toViewController
            foregroundViewController = fromViewController
        }
        
        let backgroundImageViewMaybe = (backgroundViewController as? ZoomingIconTransitionDelegate)?.zoomingIconImageViewForTransition(self)
        let foregroundImageViewMaybe = (foregroundViewController as? ZoomingIconTransitionDelegate)?.zoomingIconImageViewForTransition(self)
        
        assert(backgroundImageViewMaybe != nil, "Cannot find image view in background view controller")
        assert(foregroundImageViewMaybe != nil, "Cannot find image view in foreground view controller")
        
        let backgroundImageView = backgroundImageViewMaybe!
        let foregroundImageView = foregroundImageViewMaybe!
        
        let backgroundColoredViewMaybe = (backgroundViewController as? ZoomingIconTransitionDelegate)?.zoomingIconColoredViewForTransition(self)
        let foregroundColoredViewMaybe = (foregroundViewController as? ZoomingIconTransitionDelegate)?.zoomingIconColoredViewForTransition(self)
        
        assert(backgroundColoredViewMaybe != nil, "Cannot find colored view in background view controller")
        assert(foregroundColoredViewMaybe != nil, "Cannot find colored view in foreground view controller")
        
        let backgroundColoredView = backgroundColoredViewMaybe!
        let foregroundColoredView = foregroundColoredViewMaybe!
        
        containerView!.addSubview(backgroundViewController!.view)
        let snapshotOfColoredView = backgroundColoredView.snapshotViewAfterScreenUpdates(false)
        
        let snapshotOfImageView = UIImageView(image: backgroundImageView.image)
        snapshotOfImageView.contentMode = .ScaleAspectFit
        
        backgroundColoredView.hidden = true
        foregroundColoredView.hidden = true
        
        backgroundImageView.hidden = true
        foregroundImageView.hidden = true
        
        containerView!.backgroundColor = UIColor.whiteColor()
        containerView!.addSubview(backgroundViewController!.view)
        containerView!.addSubview(snapshotOfColoredView)
        containerView!.addSubview(foregroundViewController!.view)
        containerView!.addSubview(snapshotOfImageView)
        
        let foregroundViewBackgroundColor = foregroundViewController!.view.backgroundColor
        foregroundViewController!.view.backgroundColor = UIColor.clearColor()
        
        var preTransitionState = TransitionState.Initial
        var postTransitionState = TransitionState.Final
        
        if operation == .Pop {
            preTransitionState = TransitionState.Final
            postTransitionState = TransitionState.Initial
        }
        
        configureViewsForState(preTransitionState, containerView: containerView!, backgroundViewController: backgroundViewController!, viewsInBackground: (backgroundColoredView, backgroundImageView), viewsInForeground: (foregroundColoredView, foregroundImageView), snapshotViews: (snapshotOfColoredView, snapshotOfImageView))
        
        foregroundViewController!.view.layoutIfNeeded()
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            [self]
            self.configureViewsForState(postTransitionState, containerView: containerView!, backgroundViewController: backgroundViewController!, viewsInBackground: (backgroundColoredView, backgroundImageView), viewsInForeground: (foregroundColoredView, foregroundImageView), snapshotViews: (snapshotOfColoredView, snapshotOfImageView))
            }, completion: {
                (finished) in
                
                backgroundViewController!.view.transform = CGAffineTransformIdentity
                
                snapshotOfColoredView.removeFromSuperview()
                snapshotOfImageView.removeFromSuperview()
                
                backgroundColoredView.hidden = false
                foregroundColoredView.hidden = false
                
                backgroundImageView.hidden = false
                foregroundImageView.hidden = false
                
                foregroundViewController!.view.backgroundColor = foregroundViewBackgroundColor
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is ZoomingIconTransitionDelegate &&
            toVC is ZoomingIconTransitionDelegate {
                self.operation = operation
                return self
        }
        else {
            return nil
        }
    }
    
    func configureViewsForState(state: TransitionState, containerView: UIView, backgroundViewController: UIViewController, viewsInBackground: ZoomingViews, viewsInForeground: ZoomingViews, snapshotViews: ZoomingViews) {
        switch state {
        case .Initial:
            backgroundViewController.view.transform = CGAffineTransformIdentity
            backgroundViewController.view.alpha = 1
            
            snapshotViews.coloredView.transform = CGAffineTransformIdentity
            snapshotViews.coloredView.frame = containerView.convertRect(viewsInBackground.coloredView.frame, fromView: viewsInBackground.coloredView.superview)
            snapshotViews.imageView.frame = containerView.convertRect(viewsInBackground.imageView.frame, fromView: viewsInBackground.imageView.superview)
            
        case .Final:
            backgroundViewController.view.transform = CGAffineTransformMakeScale(kZoomingIconTransitionBackgroundScale, kZoomingIconTransitionBackgroundScale)
            backgroundViewController.view.alpha = 0
            
            snapshotViews.coloredView.transform = CGAffineTransformMakeScale(kZoomingIconTransitionZoomedScale, kZoomingIconTransitionZoomedScale)
            snapshotViews.coloredView.center = containerView.convertPoint(viewsInForeground.imageView.center, fromView: viewsInForeground.imageView.superview)
            snapshotViews.imageView.frame = containerView.convertRect(viewsInForeground.imageView.frame, fromView: viewsInForeground.imageView.superview)
            
        default:
            ()
        }
    }
}
