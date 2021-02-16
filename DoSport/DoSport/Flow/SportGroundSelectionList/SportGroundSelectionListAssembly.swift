//
//  SportGroundSelectionListAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 15/02/2021.
//

import Foundation

final class SportGroundSelectionListAssembly: Assembly {
    
    private let completion: (String) -> Void
    
    init(completion: @escaping (String) -> Void) {
        self.completion = completion
    }
    
    func makeModule() -> SportGroundSelectionListViewController {
        let viewModel = SportGroundSelectionListViewModel()
        let viewController = SportGroundSelectionListViewController(
            viewModel: viewModel,
            completion: completion
        )
        return viewController
    }
}
