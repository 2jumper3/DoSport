//
//  DSNavigationController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/01/2021.
//

import UIKit

final class DSNavigationController: UINavigationController {
    
    private let navBarSeparatorView = DSSeparatorView()
    
    override var preferredStatusBarStyle : UIStatusBarStyle {

        if let topVC = viewControllers.last {
            //return the status property of each VC, look at step 2
            return topVC.preferredStatusBarStyle
        }

        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = Colors.darkBlue
        
        navigationBar.addSubview(navBarSeparatorView)
        
        setStatusBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        navBarSeparatorView.snp.makeConstraints {
            $0.width.centerX.equalToSuperview()
            $0.height.equalTo(1)
            $0.bottom.equalTo(self.navigationBar.snp.bottom).offset(1)
        }
    }
}

//MARK: Private API

private extension DSNavigationController {
    
    func setStatusBar() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = Colors.darkBlue
            navigationBar.standardAppearance = navBarAppearance
            navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
}
