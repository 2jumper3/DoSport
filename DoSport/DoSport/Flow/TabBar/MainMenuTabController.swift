//
//  MainMenuTabController.swift
//  DoSport
//
//  Created by Sergey on 24.12.2020.
//

import UIKit

final class MainMenuTabController: UITabBarController, UINavigationControllerDelegate {
    
    weak var coordinator: MainTabBarCoordinator?
    unowned var feedCoordinator: FeedCoordinator?
    unowned var userMainCoordinator: UserMainCoordinator?
    unowned var mainSportTypeSelectionCoordinator: MainSportTypeSelectionCoordinator?
    
    private let tabBarHeight: CGFloat = CGFloat(UIDevice.getDeviceRelatedTabBarHeight())
    private let tabBarItems: [TabBarItem] = [.home, .map, .chat, .user]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Outlets
    
    private var customTabBar: CustomTabView!
    private let topSeparatorView = DSSeparatorView()
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomTabBarItem()
        
        selectedIndex = 0
        delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        topSeparatorView.snp.makeConstraints {
            $0.width.centerX.equalTo(view)
            $0.height.equalTo(1)
            $0.top.equalTo(customTabBar.snp.top).offset(-1)
        }
        
        customTabBar.snp.makeConstraints {
            $0.left.right.equalTo(tabBar)
            $0.height.equalTo(tabBarHeight)
            $0.bottom.equalTo(tabBar.snp.bottom)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

//MARK: Public API

extension MainMenuTabController {
    
    func setupTabBarViewControllers() {
        var tabViewControllers: [UIViewController]? = []
        
        self.tabBarItems.forEach { tabBarItem in
            
            if tabBarItem.viewController == TabBarItem.home.rawValue {
                let navigationController = DSNavigationController()
                let feedCoordinator = FeedCoordinator(navController: navigationController)
                
                self.feedCoordinator = feedCoordinator
                
                feedCoordinator.start()
                
                tabViewControllers?.append(navigationController)
                
            } else if tabBarItem.viewController == TabBarItem.user.rawValue {
                let navigationController = DSNavigationController()
                let userMainCoordinator = UserMainCoordinator(navController: navigationController)
                
                self.userMainCoordinator = userMainCoordinator
                
                userMainCoordinator.start()
                
                tabViewControllers?.append(navigationController)
                
            } else if tabBarItem.viewController == TabBarItem.map.rawValue  {
                let navigationController = DSNavigationController()
                let mainSportTypeSelectionCoordinator = MainSportTypeSelectionCoordinator(navController: navigationController)
                
                self.mainSportTypeSelectionCoordinator = mainSportTypeSelectionCoordinator
                
                mainSportTypeSelectionCoordinator.start()
                
                tabViewControllers?.append(navigationController)
                
            } else {
                tabViewControllers?.append(UIViewController())
            }
        }
        
        self.viewControllers = tabViewControllers
    }
}

//MARK: Private API

private extension MainMenuTabController {
    
    func setupCustomTabBarItem() {
        let frame = CGRect(
            x: tabBar.frame.origin.x,
            y: tabBar.frame.origin.x,
            width: tabBar.frame.width,
            height: tabBarHeight
        )
        
        tabBar.isHidden = true
        
        customTabBar = CustomTabView(menuItems: self.tabBarItems, frame: frame)
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.itemTapped = changeTab
        customTabBar.onActiveItemTapped = popToRootController
        view.addSubview(customTabBar)
        customTabBar.addSubview(topSeparatorView)
        
        view.layoutIfNeeded()
    }
    
    func changeTab(tab: Int) {
        self.selectedIndex = tab
    }
    
    func popToRootController() {
        if self.viewControllers?[self.selectedIndex] == self.feedCoordinator?.navigationController {
            feedCoordinator?.popToRoot()
        } else if self.viewControllers?[self.selectedIndex] == self.userMainCoordinator?.navigationController {
            userMainCoordinator?.popToRoot()
        } else if self.viewControllers?[self.selectedIndex] == self.mainSportTypeSelectionCoordinator?.navigationController {
            mainSportTypeSelectionCoordinator?.popToRoot()
        }
    }
}

// MARK: - UITabBarControllerDelegate -

extension MainMenuTabController: UITabBarControllerDelegate {
    
    func tabBarController(
        _ tabBarController: UITabBarController,
        animationControllerForTransitionFrom fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return MyTransition(viewControllers: tabBarController.viewControllers)
    }
}

// MARK: - UIViewControllerAnimatedTransitioning -

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
