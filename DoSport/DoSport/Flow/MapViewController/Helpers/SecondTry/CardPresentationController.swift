//
//  File1.swift
//  DoSport
//
//  Created by Sergey on 02.02.2021.
//

import UIKit

final class CardPresentationController: UIPresentationController {
    var touchForwardingView: PSPDFTouchForwardingView!
    override var shouldPresentInFullscreen: Bool {
        return false
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = containerView!.bounds
        let height = bounds.height / 5.7
        return CGRect(x: 0,
                      y: bounds.maxY - 88 - height,
                      width: bounds.width,
                      height: height)
    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        touchForwardingView = PSPDFTouchForwardingView(frame: containerView!.bounds)
        touchForwardingView.passthroughViews = [presentingViewController.view];
//        containerView?.insertSubview(touchForwardingView, at: 0)
        containerView?.addSubview(presentedView!)
    }
}
