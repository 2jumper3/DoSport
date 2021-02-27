//
//  DSNavigationController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/01/2021.
//

import UIKit

final class DSNavigationController: UINavigationController {
    
    private let navBarSeparatorView = DSSeparatorView()
    
    private let hasSeparator: Bool
    
    override var preferredStatusBarStyle : UIStatusBarStyle {

        if let topVC = viewControllers.last {
            //return the status property of each VC, look at step 2
            return topVC.preferredStatusBarStyle
        }

        return .default
    }
    
    init(withSeparator: Bool = true) {
        self.hasSeparator = withSeparator
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = Colors.darkBlue
        
        if hasSeparator {
            navigationBar.addSubview(navBarSeparatorView)
        }
        
        setStatusBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if hasSeparator {
            navBarSeparatorView.snp.makeConstraints {
                $0.width.centerX.equalToSuperview()
                $0.height.equalTo(1)
                $0.bottom.equalTo(self.navigationBar.snp.bottom).offset(1)
            }
        }
    }
}

//MARK: Public API

extension DSNavigationController {
    
    func hasSeparator(_ value: Bool) {
        self.navBarSeparatorView.isHidden = !value
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
