//
//  MainMenuTabController.swift
//  DoSport
//
//  Created by Sergey on 24.12.2020.
//

import UIKit

final class MainMenuTabController: UITabBarController, UINavigationControllerDelegate {

    // MARK: - Outlets
    let backGroundView: UIView = {
        let view = UIView()
        return view
    }()
    var customTabBar: CustomTabView!

    // MARK: - Properteis
    var tabBarHeight: CGFloat = 88.0

    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.loadTabBar()
        delegate = self
    }

    // MARK: - Setup custom tabbar
    private func loadTabBar() {
        let tabItems: [TabBarItem] = [.home, .map, .list, .chat, .user]
        self.setupCustomTabBar(tabItems) { (controllers) in
            self.viewControllers = controllers
            let navControllers = controllers[0] as? UINavigationController
            let controller = navControllers?.viewControllers.first as? MainViewController
        }
        self.selectedIndex = 0
    }

    private func setupCustomTabBar(_ items: [TabBarItem],
                                   completion: @escaping ([UIViewController]) -> Void) {
        let frame = CGRect(x: tabBar.frame.origin.x, y: tabBar.frame.origin.x, width: tabBar.frame.width, height: tabBarHeight)

        var controllers = [UIViewController]()

        tabBar.isHidden = true

        self.customTabBar = CustomTabView(menuItems: items, frame: frame)
        self.customTabBar.translatesAutoresizingMaskIntoConstraints = false
        self.customTabBar.itemTapped = self.changeTab
        self.view.addSubview(customTabBar)

        customTabBar.snp.makeConstraints { (make) in
            make.leading.equalTo(tabBar.snp.leading)
            make.trailing.equalTo(tabBar.snp.trailing)
            make.width.equalTo(tabBar.snp.width)
            make.height.equalTo(tabBarHeight)
            make.bottom.equalTo(tabBar.snp.bottom)
        }

        for item in 0 ..< items.count {
            controllers.append(items[item].viewController)
        }

        self.view.layoutIfNeeded()
        completion(controllers)
    }

    func changeTab(tab: Int) {
        self.selectedIndex = tab
    }
}
// MARK: - Animation change viewControllers
extension MainMenuTabController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController,
                          animationControllerForTransitionFrom fromVC: UIViewController,
                          to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MyTransition(viewControllers: tabBarController.viewControllers)
    }
}

class MyTransition: NSObject, UIViewControllerAnimatedTransitioning {

    let viewControllers: [UIViewController]?
    let transitionDuration: Double = 0.25

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
