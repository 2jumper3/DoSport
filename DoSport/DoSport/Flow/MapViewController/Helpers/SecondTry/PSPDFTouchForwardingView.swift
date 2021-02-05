//
//  File5.swift
//  DoSport
//
//  Created by Sergey on 02.02.2021.
//

import UIKit

// This class allows the "presentedController" to receive touches
// https://pspdfkit.com/blog/2015/presentation-controllers/
final class PSPDFTouchForwardingView: UIView {
    
    final var passthroughViews: [UIView] = []
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let hitView = super.hitTest(point, with: event) else { return nil }
        guard hitView == self else { return hitView }
        
        for passthroughView in passthroughViews {
            let point = convert(point, to: passthroughView)
            if let passthroughHitView = passthroughView.hitTest(point, with: event) {
                return passthroughHitView
            }
        }
        
        return self
    }
}
