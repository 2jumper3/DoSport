//
//  SportTypeListAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import Foundation

final class SportTypeListAssembly: Assembly {
    
    func makeModule() -> SportTypeListViewController {
        let viewModel = SportTypeListViewModel()
        let viewController = SportTypeListViewController(viewModel: viewModel)
        return viewController
    }
}
