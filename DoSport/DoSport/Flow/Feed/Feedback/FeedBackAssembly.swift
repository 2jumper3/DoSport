//
//  FeedBackAssembly.swift
//  DoSport
//
//  Created by Dmitrii Diadiushkin on 31.05.2021.
//

import Foundation

final class FeedBackAssembly: Assembly {
    
    func makeModule() -> FeedBackViewController {
        let viewController = FeedBackViewController()
        return viewController
    }
}
