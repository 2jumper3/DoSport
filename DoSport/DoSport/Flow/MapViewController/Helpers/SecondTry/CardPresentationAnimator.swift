//
//  File3.swift
//  DoSport
//
//  Created by Sergey on 02.02.2021.
//

import UIKit

class CardPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let containerView = transitionContext.containerView
        
        let animationDuration = transitionDuration(using: transitionContext)
        
        toViewController.view.transform = CGAffineTransform(translationX: containerView.bounds.width, y: 0)
        toViewController.view.layer.shadowColor = UIColor.black.cgColor
        toViewController.view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        toViewController.view.layer.shadowOpacity = 0.3
        toViewController.view.layer.cornerRadius = 4.0
        toViewController.view.clipsToBounds = true
        
        containerView.addSubview(toViewController.view)
                
        UIView.animate(withDuration: animationDuration, animations: {
            toViewController.view.transform = CGAffineTransform.identity
            }, completion: { finished in
                transitionContext.completeTransition(finished)
        })

    }
}
