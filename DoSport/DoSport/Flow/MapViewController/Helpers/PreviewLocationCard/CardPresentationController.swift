//
//  CardPresentationController.swift
//  DoSport
//
//  Created by Sergey on 23.01.2021.
//

import UIKit

final class CardPresentationController: UIPresentationController {
    
    override var frameOfPresentedViewInContainerView : CGRect {
        let height: CGFloat = 110
        return CGRect(x: 0, y: containerView!.bounds.height - height, width: containerView!.bounds.width, height: height)
    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView?.addSubview(presentedView!)
    }
}
