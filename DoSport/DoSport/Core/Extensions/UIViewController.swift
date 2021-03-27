//
//  UIViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/02/2021.
//

import UIKit

//MARK: - Container ViewController methods -

extension UIViewController {
    
    /// создать дженерик  контейнер child VC. Добавить в нужый parent VC
    func setup<T>(_ container: inout T?) where T: UIViewController {
        guard let tabController = tabBarController else { return }
        
        container = T(nibName: String(describing: T.self), bundle: nil)
        container?.view.frame = tabController.view.frame
        container?.view.frame.origin.y = tabController.view.frame.maxY
    }
    
    /// анимцией показать дженерик контейнер child VC.
    func present<T>(_ container: T?) where T: UIViewController {
        guard container != nil else { return }
        
        tabBarController?.view.addSubview(container!.view)
        tabBarController?.addChild(container!)
        container!.didMove(toParent: tabBarController)
        
        let y: CGFloat = view.frame.maxY - container!.view.frame.height - 10
        
        UIView.animate(withDuration: 0.3) {
            container!.view.frame.origin.y = y
        } completion: { value in
            UIView.animate(withDuration: 0.3) {
                container!.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            }
        }
    }
    
    /// анимцией скрыть показанный дженерик контейнер child VC.
    func dismiss<T>(
        _ container: T?,
        from view: UIView,
        withDuration duration: Double = 0.2,
        completion: @escaping () -> Swift.Void = { return }
    ) where T: UIViewController {
        
        guard container != nil else { return }
        
        UIView.animate(withDuration: duration) {
            UIView.animate(withDuration: duration) {
                container!.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            } completion: { value in
                UIView.animate(withDuration: duration) {
                    container!.view.frame.origin.y = view.frame.maxY
                } completion: { value in
                    container!.willMove(toParent: nil)
                    container!.removeFromParent()
                    container!.view.removeFromSuperview()
                    completion()
                }
            }
        }
    }
}
