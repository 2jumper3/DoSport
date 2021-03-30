//
//  FeedAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import Foundation

final class FeedAssembly: Assembly {
    
    func makeModule() -> FeedViewController {
        let eventNetworkService = EventNetworkService()
        let viewModel = FeedViewModel(eventNetworkService: eventNetworkService)
        let viewController = FeedViewController(viewModel: viewModel)
        return viewController
    }
}
