//
//  SportGroundSelectionListAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 15/02/2021.
//

import Foundation

final class SportGroundSelectionListAssembly: Assembly {
    
    func makeModule() -> SportGroundSelectionListViewController {
        let viewModel = SportGroundSelectionListViewModel()
        let viewController = SportGroundSelectionListViewController(viewModel: viewModel)
        return viewController
    }
}
