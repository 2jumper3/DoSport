//
//  DSNavigationController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/01/2021.
//

import UIKit

final class DSNavigationController: UINavigationController {
    
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
    }
}
