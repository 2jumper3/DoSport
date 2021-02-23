//
//  SportTypeListAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import Foundation

final class SportTypeListAssembly: Assembly {
    func makeModule() -> SportTypeListViewController {
        let viewModel = SportTypeListViewModel()
        let vc = SportTypeListViewController(viewModel: viewModel)
        return vc
    }
}
