//
//  FeedAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import Foundation

final class FeedAssembly: Assembly {
    
    func makeModule() -> FeedViewController {
        let requestFactory = RequestsManager.shared
        let viewModel = FeedViewModel(requestFactory: requestFactory)
        let viewController = FeedViewController(viewModel: viewModel)
        return viewController
    }
}
