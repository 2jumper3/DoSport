//
//  SportTypeGridAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import Foundation

final class SportTypeGridAssembly: Assembly {
    
    func makeModule() -> SportTypeGridViewController {
        let requestManager = RequestsManager.shared
        let viewModel = SportTypeGridViewModelImplementation(requestManager: requestManager)
        let vc = SportTypeGridViewController(viewModel: viewModel)
        viewModel.viewController = vc
        return vc
    }
}