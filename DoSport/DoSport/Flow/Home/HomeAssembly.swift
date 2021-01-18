//
//  HomeAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import Foundation

final class HomeAssembly: Assembly {
    
    func makeModule() -> HomeViewController {
        let requestFactory = RequestFactory()
        let viewModel = HomeViewModel(requestFactory: requestFactory)
        let viewController = HomeViewController(viewModel: viewModel)
        return viewController
    }
}
