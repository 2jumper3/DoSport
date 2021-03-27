//
//  OnBoardingAssembly.swift
//  DoSport
//
//  Created by Sergey on 17.01.2021.
//

import Foundation

final class OnBoardingAssembly: Assembly {
    
    func makeModule() -> OnBoardingViewController {
        let viewController = OnBoardingViewController()
        return viewController
    }
}
