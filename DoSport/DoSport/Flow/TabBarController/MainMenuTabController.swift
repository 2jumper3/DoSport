//
//  MainMenuTabController.swift
//  DoSport
//
//  Created by Sergey on 24.12.2020.
//

import UIKit

final class MainMenuTabController: UITabBarController, UINavigationControllerDelegate {
    
    private var customTabBar: CustomTabView!
    
    private var tabBarHeight: CGFloat = 0
    
    private let topSeparatorView = DSSeparatorView()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(topSeparatorView)
        
        loadTabBar()
        delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        topSeparatorView.snp.makeConstraints {
            $0.width.centerX.equalTo(view)
            $0.height.equalTo(1)
            $0.bottom.equalTo(customTabBar.snp.top).offset(1)
        }
    }
    
    // MARK: - Setup custom tabbar
    
    private func loadTabBar() {
        
        let tabItems: [TabBarItem] = [.home, .map, .chat, .user]
        
        setupCustomTabBar(tabItems) { controllers in
            self.viewControllers = controllers
        }
        
        selectedIndex = 0
    }
    
    private func setupCustomTabBar(
        _ items: [TabBarItem],
        completion: @escaping ([UIViewController]) -> Void
    ) {
        setupDeviceRelatedTabBarHeight()
        
        let frame = CGRect(
            x: tabBar.frame.origin.x,
            y: tabBar.frame.origin.x,
            width: tabBar.frame.width,
            height: tabBarHeight
        )
        
        var controllers = [UIViewController]()
        
        tabBar.isHidden = true
        
        customTabBar = CustomTabView(menuItems: items, frame: frame)
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.itemTapped = changeTab
        view.addSubview(customTabBar)
        
        customTabBar.snp.makeConstraints { (make) in
            make.left.right.equalTo(tabBar)
            make.height.equalTo(tabBarHeight)
            make.bottom.equalTo(tabBar.snp.bottom)
        }
        
        for item in 0 ..< items.count {
            controllers.append(items[item].viewController)
        }
        
        view.layoutIfNeeded()
        completion(controllers)
    }
    
    private func changeTab(tab: Int) {
        self.selectedIndex = tab
    }
    
    private func setupDeviceRelatedTabBarHeight() {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136, 1334, 1920, 2208: tabBarHeight = 49 // "iPhone 5 or 5S or 5C" "iPhone 6/6S/7/8" "iPhone 6+/6S+/7+/8+"
            case 2436, 2688, 1792: tabBarHeight = 83 // "iPhone X/XS/11 Pro""iPhone XS Max/11 Pro Max""iPhone XR/ 11 "
            default: break
            }
        }
    }
}

// MARK: - Animation change viewControllers

extension MainMenuTabController: UITabBarControllerDelegate {
    
    func tabBarController(
        _ tabBarController: UITabBarController,
        animationControllerForTransitionFrom fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return MyTransition(viewControllers: tabBarController.viewControllers)
    }
}

final class MyTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let viewControllers: [UIViewController]?
    private let transitionDuration: Double = 0.25
    
    init(viewControllers: [UIViewController]?) {
        self.viewControllers = viewControllers
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(transitionDuration)
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let fromView = fromVC.view,
            let fromIndex = getIndex(for: fromVC),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toView = toVC.view,
            let toIndex = getIndex(for: toVC)
        else {
            transitionContext.completeTransition(false)
            return
        }
        
        let frame = transitionContext.initialFrame(for: fromVC)
        var fromFrameEnd = frame
        var toFrameStart = frame
        
        fromFrameEnd.origin.x = toIndex > fromIndex ? frame.origin.x - frame.width : frame.origin.x + frame.width
        toFrameStart.origin.x = toIndex > fromIndex ? frame.origin.x + frame.width : frame.origin.x - frame.width
        toView.frame = toFrameStart
        
        DispatchQueue.main.async {
            transitionContext.containerView.addSubview(toView)
            
            UIView.animate(withDuration: self.transitionDuration, animations: {
                fromView.frame = fromFrameEnd
                toView.frame = frame
            }, completion: {success in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(success)
            })
        }
    }
    
    func getIndex(for controller: UIViewController) -> Int? {
        guard let vcs = self.viewControllers else { return nil }
        
        for (index, thisVC) in vcs.enumerated() {
            if thisVC == controller {
                return index
            }
        }
        
        return nil
    }
}
