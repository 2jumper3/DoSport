//
//  File2.swift
//  DoSport
//
//  Created by Sergey on 02.02.2021.
//

import UIKit

class CardTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresentedViewController presented: UIViewController,
                                                          presenting: UIViewController?,
                                                                                   sourceViewController source: UIViewController) -> UIPresentationController? {
        
        return CardPresentationController(presentedViewController: presented,
                                          presenting: presenting)
    }
    
    func animationController(forPresentedController presented: UIViewController, presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardPresentationAnimator()
    }
    
    func animationController(forDismissedController dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardDismissionAnimator()
    }
}
