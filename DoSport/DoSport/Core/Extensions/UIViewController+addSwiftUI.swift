//
//  UIViewController+addSwiftUI.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 12/03/2021.
//

import UIKit.UIViewController
#if canImport(SwiftUI)
import SwiftUI
#endif

@available(iOS 13.0, *)
extension UIViewController {

    /// Add a SwiftUI `View` as a child of the input `UIView`.
    /// - Parameters:
    ///   - swiftUIView: The SwiftUI `View` to add as a child.
    ///   - view: The `UIView` instance to which the view should be added.
    func addSubSwiftUIView<Content>(_ swiftUIView: Content, to view: UIView) where Content : View {
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        addChild(hostingController)
        view.addSubview(hostingController.view)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
            view.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        hostingController.didMove(toParent: self)
    }
}
